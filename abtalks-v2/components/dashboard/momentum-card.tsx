import { Compass } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import type { ChallengeDay } from "@/lib/types";

interface MomentumCardProps {
  day: ChallengeDay;
  isFirstDay: boolean;
}

function getMomentumCopy(day: ChallengeDay, isFirstDay: boolean): { message: string; cta: string } {
  if (isFirstDay) {
    return {
      message: "Build something small today, then submit your GitHub and LinkedIn proof to start your streak.",
      cta: "Start Day 1",
    };
  }

  if (day.status === "completed") {
    return {
      message: `Day ${day.dayNumber} is locked in. Come back tomorrow to keep your streak alive.`,
      cta: "Review today",
    };
  }

  const githubDone = day.proofs.github.submitted;
  const linkedinDone = day.proofs.linkedin.submitted;

  if (!githubDone && !linkedinDone) {
    return {
      message: `Nothing submitted yet for Day ${day.dayNumber}. Start with your GitHub proof.`,
      cta: `Open Day ${day.dayNumber}`,
    };
  }

  if (githubDone && !linkedinDone) {
    return {
      message: `GitHub is done for Day ${day.dayNumber} — add your LinkedIn post to finish today.`,
      cta: "Add LinkedIn proof",
    };
  }

  if (!githubDone && linkedinDone) {
    return {
      message: `LinkedIn is done for Day ${day.dayNumber} — add your GitHub proof to finish today.`,
      cta: "Add GitHub proof",
    };
  }

  return {
    message: `Both proofs are in for Day ${day.dayNumber}. Mark it complete to extend your streak.`,
    cta: `Complete Day ${day.dayNumber}`,
  };
}

export function MomentumCard({ day, isFirstDay }: MomentumCardProps) {
  const { message, cta } = getMomentumCopy(day, isFirstDay);

  return (
    <Card className="border-accent/15 bg-accent-soft/40">
      <div className="flex items-start gap-3">
        <div className="mt-0.5 flex h-8 w-8 flex-none items-center justify-center rounded-full bg-surface">
          <Compass size={16} strokeWidth={2.2} className="text-accent-strong" />
        </div>
        <div className="flex-1">
          <p className="eyebrow">Next best action</p>
          <p className="mt-1 text-body text-ink">{message}</p>
          <Button href={`/day/${day.dayNumber}`} size="sm" className="mt-4">
            {cta}
          </Button>
        </div>
      </div>
    </Card>
  );
}
