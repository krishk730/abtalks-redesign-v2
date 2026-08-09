"use client";

import * as React from "react";
import { MOCK_ACHIEVEMENTS, MOCK_STUDENT, buildMockDays } from "@/lib/mock-data";
import type {
  Achievement,
  ChallengeDay,
  ChallengeState,
  ChallengeStats,
  PersistedChallengeState,
  ProofKind,
} from "@/lib/types";

const STORAGE_KEY = "abtalks:challenge:v1";

// ---------------------------------------------------------------------------
// Initial state — identical on server and client. Never read localStorage
// here; doing so would make the very first render diverge between the
// server-rendered HTML and the client's first pass, which is what causes
// React hydration mismatches. localStorage is only consulted after mount,
// inside a useEffect (see ChallengeProvider below).
// ---------------------------------------------------------------------------

function getInitialState(): ChallengeState {
  return {
    student: MOCK_STUDENT,
    days: buildMockDays(),
    achievements: MOCK_ACHIEVEMENTS,
    isHydrated: false,
  };
}

// ---------------------------------------------------------------------------
// Reducer
// ---------------------------------------------------------------------------

type Action =
  | { type: "HYDRATE"; payload: Partial<PersistedChallengeState> }
  | { type: "SUBMIT_PROOF"; dayNumber: number; kind: ProofKind; url: string }
  | { type: "COMPLETE_DAY"; dayNumber: number }
  | { type: "RESET_PROGRESS" };

function withUpdatedDay(
  days: ChallengeDay[],
  dayNumber: number,
  updater: (day: ChallengeDay) => ChallengeDay
): ChallengeDay[] {
  return days.map((day) => (day.dayNumber === dayNumber ? updater(day) : day));
}

function reducer(state: ChallengeState, action: Action): ChallengeState {
  switch (action.type) {
    case "HYDRATE": {
      // Light shape validation: only trust persisted data if it matches the
      // length of the mock dataset. Anything else (corrupted, stale-shape,
      // or from a future version of the app) falls back to mock defaults
      // instead of crashing the app.
      const days =
        action.payload.days && action.payload.days.length === state.days.length
          ? action.payload.days
          : state.days;
      const achievements =
        action.payload.achievements && action.payload.achievements.length === state.achievements.length
          ? action.payload.achievements
          : state.achievements;

      return { ...state, days, achievements, isHydrated: true };
    }

    case "SUBMIT_PROOF": {
      const trimmedUrl = action.url.trim();
      if (!trimmedUrl) return state;

      const days = withUpdatedDay(state.days, action.dayNumber, (day) => ({
        ...day,
        proofs: {
          ...day.proofs,
          [action.kind]: {
            submitted: true,
            url: trimmedUrl,
            submittedAt: new Date().toISOString(),
          },
        },
      }));

      return { ...state, days };
    }

    case "COMPLETE_DAY": {
      const target = state.days.find((day) => day.dayNumber === action.dayNumber);
      const bothProofsSubmitted = target?.proofs.github.submitted && target?.proofs.linkedin.submitted;
      if (!target || !bothProofsSubmitted || target.status === "completed") return state;

      const days = withUpdatedDay(state.days, action.dayNumber, (day) => ({
        ...day,
        status: "completed",
        completedAt: new Date().toISOString(),
      }));

      return { ...state, days };
    }

    case "RESET_PROGRESS": {
      // Useful for demoing the first-day / 0-streak / empty-profile states
      // in later steps without needing a second mock profile.
      return {
        ...state,
        days: buildMockDays().map((day) => ({
          ...day,
          status: day.dayNumber === 1 ? "today" : "upcoming",
          proofs: {
            github: { submitted: false },
            linkedin: { submitted: false },
          },
          completedAt: undefined,
        })),
        achievements: state.achievements.map((achievement) => ({
          ...achievement,
          unlocked: false,
          unlockedAt: undefined,
        })),
      };
    }

    default:
      return state;
  }
}

// ---------------------------------------------------------------------------
// Derived stats — always computed from `days`, never stored, so they can
// never drift out of sync with the actual per-day record.
// ---------------------------------------------------------------------------

function computeStats(state: ChallengeState): ChallengeStats {
  const { days, student, achievements } = state;

  const daysCompleted = days.filter((day) => day.status === "completed").length;

  let currentStreak = 0;
  for (let dayNumber = student.currentDay - 1; dayNumber >= 1; dayNumber -= 1) {
    const day = days[dayNumber - 1];
    if (day && day.status === "completed") {
      currentStreak += 1;
    } else {
      break;
    }
  }

  let longestStreak = 0;
  let running = 0;
  for (const day of days) {
    if (day.status === "completed") {
      running += 1;
      longestStreak = Math.max(longestStreak, running);
    } else {
      running = 0;
    }
  }
  longestStreak = Math.max(longestStreak, currentStreak);

  const missedDayNumbers = days.filter((day) => day.status === "missed").map((day) => day.dayNumber);
  const completionPercent = Math.round((daysCompleted / student.totalDays) * 100);
  const isFirstDay = daysCompleted === 0 && currentStreak === 0 && missedDayNumbers.length === 0;
  const isEmptyProfile = daysCompleted === 0 && achievements.every((a) => !a.unlocked);

  return {
    daysCompleted,
    currentStreak,
    longestStreak,
    completionPercent,
    isFirstDay,
    isEmptyProfile,
    hasMissedDays: missedDayNumbers.length > 0,
    missedDayNumbers,
  };
}

// ---------------------------------------------------------------------------
// Context
// ---------------------------------------------------------------------------

interface ChallengeContextValue {
  state: ChallengeState;
  stats: ChallengeStats;
  getDay: (dayNumber: number) => ChallengeDay | undefined;
  submitProof: (dayNumber: number, kind: ProofKind, url: string) => void;
  completeDay: (dayNumber: number) => void;
  resetProgress: () => void;
}

const ChallengeContext = React.createContext<ChallengeContextValue | null>(null);

export function ChallengeProvider({ children }: { children: React.ReactNode }) {
  const [state, dispatch] = React.useReducer(reducer, undefined, getInitialState);

  // Hydrate from localStorage exactly once, after mount (client-only).
  // Wrapped in try/catch so private-browsing / disabled-storage / malformed
  // JSON never crashes the app — it just falls back to the mock defaults.
  React.useEffect(() => {
    try {
      const raw = window.localStorage.getItem(STORAGE_KEY);
      const payload: Partial<PersistedChallengeState> = raw ? JSON.parse(raw) : {};
      dispatch({ type: "HYDRATE", payload });
    } catch {
      dispatch({ type: "HYDRATE", payload: {} });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Persist to localStorage after every change, but only once hydration has
  // happened — otherwise the very first (pre-hydration) render would
  // overwrite real stored progress with fresh mock data.
  React.useEffect(() => {
    if (!state.isHydrated) return;
    try {
      const toPersist: PersistedChallengeState = {
        days: state.days,
        achievements: state.achievements,
      };
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify(toPersist));
    } catch {
      // Storage full or unavailable — the app keeps working in-memory.
    }
  }, [state.days, state.achievements, state.isHydrated]);

  const getDay = React.useCallback(
    (dayNumber: number) => state.days.find((day) => day.dayNumber === dayNumber),
    [state.days]
  );

  const submitProof = React.useCallback((dayNumber: number, kind: ProofKind, url: string) => {
    dispatch({ type: "SUBMIT_PROOF", dayNumber, kind, url });
  }, []);

  const completeDay = React.useCallback((dayNumber: number) => {
    dispatch({ type: "COMPLETE_DAY", dayNumber });
  }, []);

  const resetProgress = React.useCallback(() => {
    dispatch({ type: "RESET_PROGRESS" });
  }, []);

  const stats = React.useMemo(() => computeStats(state), [state]);

  const value = React.useMemo<ChallengeContextValue>(
    () => ({ state, stats, getDay, submitProof, completeDay, resetProgress }),
    [state, stats, getDay, submitProof, completeDay, resetProgress]
  );

  return <ChallengeContext.Provider value={value}>{children}</ChallengeContext.Provider>;
}

export function useChallenge(): ChallengeContextValue {
  const ctx = React.useContext(ChallengeContext);
  if (!ctx) {
    throw new Error("useChallenge must be used within a ChallengeProvider");
  }
  return ctx;
}

export type { Achievement, ChallengeDay };
