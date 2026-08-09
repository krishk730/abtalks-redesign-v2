import { RotateCcw } from "lucide-react";

interface MissedDayBannerProps {
  missedDayNumbers: number[];
  currentStreak: number;
  longestStreak: number;
}

export function MissedDayBanner({ missedDayNumbers, currentStreak, longestStreak }: MissedDayBannerProps) {
  const dayLabel = missedDayNumbers.length === 1 ? `Day ${missedDayNumbers[0]}` : `${missedDayNumbers.length} days`;

  return (
    <div className="flex items-start gap-3 rounded-card border border-accent/20 bg-accent-soft/60 p-4">
      <div className="mt-0.5 flex h-8 w-8 flex-none items-center justify-center rounded-full bg-accent-soft">
        <RotateCcw size={16} strokeWidth={2.2} className="text-accent-strong" />
      </div>
      <p className="text-body text-ink">
        <span className="font-semibold">{dayLabel} missed</span> your streak reset there — but
        you&rsquo;re back up to <span className="font-semibold">{currentStreak} days</span>. Your best
        run so far is {longestStreak} days. Keep going.
      </p>
    </div>
  );
}
