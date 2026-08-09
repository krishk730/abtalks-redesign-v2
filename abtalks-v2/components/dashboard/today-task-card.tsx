import { ArrowRight, CheckCircle2 } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ProofHealthBadge } from "@/components/shared/proof-health-badge";
import { countSubmittedProofs } from "@/lib/utils";
import type { ChallengeDay } from "@/lib/types";

interface TodayTaskCardProps {
  day: ChallengeDay;
}

export function TodayTaskCard({ day }: TodayTaskCardProps) {
  const proofsCompleted = countSubmittedProofs(day.proofs);
  const isCompleted = day.status === "completed";

  return (
    <Card>
      <div className="flex items-center justify-between">
        <p className="eyebrow">Day {day.dayNumber} of 60</p>
        {isCompleted ? (
          <span className="inline-flex items-center gap-1 text-caption font-semibold text-positive">
            <CheckCircle2 size={14} strokeWidth={2.5} />
            Complete
          </span>
        ) : (
          <ProofHealthBadge completed={proofsCompleted} />
        )}
      </div>

      <h2 className="mt-2 font-display text-heading-lg text-ink">{day.title}</h2>
      <p className="mt-2 line-clamp-2 text-body text-muted">{day.brief}</p>

      <Button
        href={`/day/${day.dayNumber}`}
        variant={isCompleted ? "secondary" : "primary"}
        className="mt-5 w-full"
      >
        {isCompleted ? "Review today's proof" : "Open today's challenge"}
        <ArrowRight size={18} strokeWidth={2.2} />
      </Button>
    </Card>
  );
}
