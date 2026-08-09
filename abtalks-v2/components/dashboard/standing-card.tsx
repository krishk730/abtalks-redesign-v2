import { Trophy } from "lucide-react";
import { Card } from "@/components/ui/card";

interface StandingCardProps {
  rank: number;
  totalParticipants: number;
  percentile: number;
}

export function StandingCard({ rank, totalParticipants, percentile }: StandingCardProps) {
  const topPercent = Math.max(1, 100 - percentile);

  return (
    <Card>
      <div className="flex items-center justify-between">
        <div>
          <p className="eyebrow">Your standing</p>
          <p className="mt-2 font-display text-heading-lg text-ink">Rank #{rank.toLocaleString("en-IN")}</p>
          <p className="mt-1 text-body text-muted">
            of {totalParticipants.toLocaleString("en-IN")} students on this track
          </p>
        </div>
        <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-accent-soft">
          <Trophy size={22} strokeWidth={2} className="text-accent-strong" />
        </div>
      </div>

      <p className="mt-4 inline-flex items-center rounded-pill bg-ink/[0.04] px-3 py-1.5 text-caption font-semibold text-ink">
        Top {topPercent}% of this cohort
      </p>
    </Card>
  );
}
