import {
  Flame,
  Trophy,
  GitCommitHorizontal,
  RotateCcw,
  Zap,
  Target,
  Medal,
  Lock,
  type LucideIcon,
} from "lucide-react";
import { Card } from "@/components/ui/card";
import type { Achievement } from "@/lib/types";

const ICON_MAP: Record<string, LucideIcon> = {
  flame: Flame,
  trophy: Trophy,
  "git-commit-horizontal": GitCommitHorizontal,
  "rotate-ccw": RotateCcw,
  zap: Zap,
  target: Target,
  medal: Medal,
};

interface AchievementsSectionProps {
  achievements: Achievement[];
  isEmptyProfile: boolean;
}

export function AchievementsSection({ achievements, isEmptyProfile }: AchievementsSectionProps) {
  const unlockedCount = achievements.filter((a) => a.unlocked).length;

  return (
    <Card>
      <div className="flex items-baseline justify-between">
        <p className="eyebrow">Achievements</p>
        <p className="text-caption text-muted">
          {isEmptyProfile ? "Complete Day 1 to start unlocking" : `${unlockedCount} of ${achievements.length}`}
        </p>
      </div>

      <div className="mt-4 grid grid-cols-2 gap-3">
        {achievements.map((achievement) => {
          const Icon = ICON_MAP[achievement.icon] ?? Trophy;

          return (
            <div
              key={achievement.id}
              className={
                achievement.unlocked
                  ? "rounded-card border border-accent/20 bg-accent-soft/50 p-3"
                  : "rounded-card border border-border bg-ink/[0.02] p-3"
              }
            >
              <div
                className={
                  achievement.unlocked
                    ? "flex h-9 w-9 items-center justify-center rounded-full bg-surface text-accent-strong"
                    : "flex h-9 w-9 items-center justify-center rounded-full bg-surface text-muted"
                }
              >
                {achievement.unlocked ? (
                  <Icon size={17} strokeWidth={2.1} />
                ) : (
                  <Lock size={15} strokeWidth={2.1} />
                )}
              </div>
              <p
                className={
                  achievement.unlocked
                    ? "mt-2 text-[0.8125rem] font-semibold leading-snug text-ink"
                    : "mt-2 text-[0.8125rem] font-semibold leading-snug text-muted"
                }
              >
                {achievement.label}
              </p>
              <p className="mt-0.5 text-[0.6875rem] leading-snug text-muted">{achievement.description}</p>
            </div>
          );
        })}
      </div>
    </Card>
  );
}
