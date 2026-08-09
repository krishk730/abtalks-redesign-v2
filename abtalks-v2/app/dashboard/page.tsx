"use client";

import { RotateCcw } from "lucide-react";
import { Container } from "@/components/layout/container";
import { StreakHero } from "@/components/dashboard/streak-hero";
import { MissedDayBanner } from "@/components/dashboard/missed-day-banner";
import { TodayTaskCard } from "@/components/dashboard/today-task-card";
import { MomentumCard } from "@/components/dashboard/momentum-card";
import { ProgressOverview } from "@/components/dashboard/progress-overview";
import { StandingCard } from "@/components/dashboard/standing-card";
import { AchievementsSection } from "@/components/dashboard/achievements-section";
import { useChallenge } from "@/lib/challenge-context";

export default function DashboardPage() {
  const { state, stats, getDay, resetProgress } = useChallenge();
  const { student, achievements } = state;

  const todayDay = getDay(student.currentDay);

  return (
    <Container className="py-6">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-caption text-muted">Welcome back</p>
          <h1 className="font-display text-heading-lg text-ink">{student.name}</h1>
          <p className="mt-0.5 text-caption text-muted">
            {student.track} · {student.collegeYear}
          </p>
        </div>
      </div>

      <div className="mt-5 flex flex-col gap-4">
        <StreakHero
          currentStreak={stats.currentStreak}
          longestStreak={stats.longestStreak}
          isFirstDay={stats.isFirstDay}
        />

        {stats.hasMissedDays && (
          <MissedDayBanner
            missedDayNumbers={stats.missedDayNumbers}
            currentStreak={stats.currentStreak}
            longestStreak={stats.longestStreak}
          />
        )}

        {todayDay && (
          <>
            <TodayTaskCard day={todayDay} />
            <MomentumCard day={todayDay} isFirstDay={stats.isFirstDay} />
          </>
        )}

        <ProgressOverview
          daysCompleted={stats.daysCompleted}
          totalDays={student.totalDays}
          completionPercent={stats.completionPercent}
          currentStreak={stats.currentStreak}
          longestStreak={stats.longestStreak}
        />

        <StandingCard
          rank={student.rank}
          totalParticipants={student.totalParticipants}
          percentile={student.percentile}
        />

        <AchievementsSection achievements={achievements} isEmptyProfile={stats.isEmptyProfile} />

        <button
          type="button"
          onClick={resetProgress}
          className="mx-auto mt-2 inline-flex items-center gap-1.5 text-caption text-muted underline decoration-border underline-offset-4 hover:text-ink"
        >
          <RotateCcw size={12} strokeWidth={2} />
          Reset to a fresh Day 1 (demo)
        </button>
      </div>
    </Container>
  );
}
