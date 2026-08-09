import { Card } from "@/components/ui/card";
import { ProgressRing } from "@/components/shared/progress-ring";

interface ProgressOverviewProps {
  daysCompleted: number;
  totalDays: number;
  completionPercent: number;
  currentStreak: number;
  longestStreak: number;
}

export function ProgressOverview({
  daysCompleted,
  totalDays,
  completionPercent,
  currentStreak,
  longestStreak,
}: ProgressOverviewProps) {
  return (
    <Card>
      <p className="eyebrow">60-day progress</p>

      <div className="mt-4 flex items-center justify-center">
        <ProgressRing percent={completionPercent}>
          <div className="text-center">
            <p className="font-display text-heading-lg text-ink">
              {daysCompleted}
              <span className="text-muted">/{totalDays}</span>
            </p>
            <p className="text-caption text-muted">days done</p>
          </div>
        </ProgressRing>
      </div>

      <div className="mt-5 grid grid-cols-3 gap-2 border-t border-border pt-4 text-center">
        <div>
          <p className="font-display text-heading text-ink">{completionPercent}%</p>
          <p className="mt-0.5 text-caption text-muted">complete</p>
        </div>
        <div>
          <p className="font-display text-heading text-ink">{currentStreak}</p>
          <p className="mt-0.5 text-caption text-muted">current streak</p>
        </div>
        <div>
          <p className="font-display text-heading text-ink">{longestStreak}</p>
          <p className="mt-0.5 text-caption text-muted">best streak</p>
        </div>
      </div>
    </Card>
  );
}
