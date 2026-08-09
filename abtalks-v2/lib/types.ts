// Core domain types for the ABTalks mocked challenge state layer.
// No backend / database — everything here describes the shape of
// client-side state that lives in React Context + localStorage.

export type Track = "Web Development" | "DSA" | "Machine Learning" | "Mobile Development";

/**
 * Status of an individual challenge day.
 * - upcoming: in the future, not yet reachable
 * - today:    the day currently active for the student
 * - completed: both proofs were submitted and the day was marked done
 * - missed:   the day passed without both proofs being submitted
 */
export type DayStatus = "upcoming" | "today" | "completed" | "missed";

export type ProofKind = "github" | "linkedin";

export interface ProofState {
  submitted: boolean;
  url?: string;
  submittedAt?: string; // ISO 8601
}

export interface DayProofs {
  github: ProofState;
  linkedin: ProofState;
}

export interface ChallengeDay {
  dayNumber: number;
  title: string;
  brief: string;
  objectives: string[];
  status: DayStatus;
  proofs: DayProofs;
  completedAt?: string; // ISO 8601, set when status becomes "completed"
}

export interface Achievement {
  id: string;
  label: string;
  description: string;
  /** Lucide icon name — rendered by the UI layer in a later step. */
  icon: string;
  unlocked: boolean;
  unlockedAt?: string; // ISO 8601
}

/**
 * Static-ish profile info. Fields here don't change as a direct result of
 * challenge activity — derived numbers (streak, completion %, etc.) are
 * computed from `days` instead of stored here, so they can never drift
 * out of sync with the actual day-by-day record.
 */
export interface StudentProfile {
  id: string;
  name: string;
  track: Track;
  collegeYear: string;
  city: string;
  totalDays: 60;
  currentDay: number;
  rank: number;
  totalParticipants: number;
  percentile: number;
  joinedAt: string; // ISO 8601
}

export interface ChallengeState {
  student: StudentProfile;
  days: ChallengeDay[];
  achievements: Achievement[];
  isHydrated: boolean;
}

/** Slice of state that is safe/useful to persist to localStorage. */
export interface PersistedChallengeState {
  days: ChallengeDay[];
  achievements: Achievement[];
}

/** Derived, computed-on-read stats — never stored directly. */
export interface ChallengeStats {
  daysCompleted: number;
  currentStreak: number;
  longestStreak: number;
  completionPercent: number;
  isFirstDay: boolean;
  isEmptyProfile: boolean;
  hasMissedDays: boolean;
  missedDayNumbers: number[];
}
