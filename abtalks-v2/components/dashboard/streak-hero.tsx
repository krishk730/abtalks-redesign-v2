import { Sparkles } from "lucide-react";
import { Card } from "@/components/ui/card";
import { StreakFlame } from "@/components/shared/streak-flame";

interface StreakHeroProps {
  currentStreak: number;
  longestStreak: number;
  isFirstDay: boolean;
}

export function StreakHero({ currentStreak, longestStreak, isFirstDay }: StreakHeroProps) {
  if (isFirstDay) {
    return (
      <Card className="bg-surface">
        <div className="flex items-center gap-3">
          <div className="flex h-16 w-16 items-center justify-center rounded-full bg-accent-soft">
            <Sparkles size={30} strokeWidth={2} className="text-accent-strong" />
          </div>
          <div>
            <p className="font-display text-heading-lg text-ink">Day 1 starts now</p>
            <p className="mt-1 text-caption text-muted">
              Submit today&rsquo;s proof to light your first streak.
            </p>
          </div>
        </div>
      </Card>
    );
  }

  return (
    <Card className="bg-surface">
      <div className="flex items-center justify-between">
        <StreakFlame streak={currentStreak} size="lg" />
        <div className="text-right">
          <p className="font-display text-heading text-ink">{longestStreak}</p>
          <p className="text-caption text-muted">best streak</p>
        </div>
      </div>
    </Card>
  );
}
