"use client";

import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ProofHealthBadge } from "@/components/shared/proof-health-badge";
import { JourneyStepper } from "@/components/day/journey-stepper";
import { ProofForm } from "@/components/day/proof-form";
import { CompleteDayButton } from "@/components/day/complete-day-button";
import { CompletionPanel } from "@/components/day/completion-panel";
import { useChallenge } from "@/lib/challenge-context";
import { countSubmittedProofs } from "@/lib/utils";
import type { ProofKind } from "@/lib/types";

export default function ChallengeDayPage({ params }: { params: { dayId: string } }) {
  const { getDay, stats, submitProof, completeDay } = useChallenge();

  const dayNumber = Number(params.dayId);
  const day = Number.isFinite(dayNumber) ? getDay(dayNumber) : undefined;

  if (!day) {
    return (
      <Container className="py-10 text-center">
        <p className="eyebrow">Day {params.dayId}</p>
        <h1 className="mt-3 font-display text-heading-lg text-ink">This day isn&rsquo;t on the track</h1>
        <p className="mt-2 text-body text-muted">Head back to your dashboard to find today&rsquo;s challenge.</p>
        <Button href="/dashboard" className="mt-6">
          Back to dashboard
        </Button>
      </Container>
    );
  }

  const proofsCompleted = countSubmittedProofs(day.proofs);
  const isCompleted = day.status === "completed";
  const isMissed = day.status === "missed";

  function handleSubmit(kind: ProofKind) {
    return (url: string) => submitProof(day!.dayNumber, kind, url);
  }

  return (
    <Container className="py-6">
      <div className="flex items-center justify-between">
        <p className="eyebrow">Day {day.dayNumber} of 60</p>
        <Badge variant={isCompleted ? "positive" : isMissed ? "negative" : "accent"}>
          {isCompleted ? "Completed" : isMissed ? "Missed" : "Today"}
        </Badge>
      </div>

      <h1 className="mt-2 font-display text-display text-ink">{day.title}</h1>

      <div className="mt-6">
        <JourneyStepper
          hasAnyProof={proofsCompleted > 0}
          githubDone={day.proofs.github.submitted}
          linkedinDone={day.proofs.linkedin.submitted}
          isCompleted={isCompleted}
        />
      </div>

      <Card className="mt-6">
        <p className="eyebrow">What to build</p>
        <p className="mt-2 text-body text-ink">{day.brief}</p>

        <p className="mt-4 text-caption font-semibold uppercase tracking-wide text-muted">
          Acceptance criteria
        </p>
        <ul className="mt-2 flex flex-col gap-2">
          {day.objectives.map((objective) => (
            <li key={objective} className="flex items-start gap-2 text-body text-ink">
              <span className="mt-2 h-1.5 w-1.5 flex-none rounded-full bg-accent" />
              {objective}
            </li>
          ))}
        </ul>
      </Card>

      {isCompleted && <div className="mt-6"><CompletionPanel dayNumber={day.dayNumber} currentStreak={stats.currentStreak} /></div>}

      <div className="mt-6 flex items-center justify-between">
        <p className="eyebrow">Proof health</p>
        <ProofHealthBadge completed={proofsCompleted} />
      </div>

      <div className="mt-3 flex flex-col gap-4">
        <ProofForm kind="github" proof={day.proofs.github} disabled={isCompleted} onSubmit={handleSubmit("github")} />
        <ProofForm kind="linkedin" proof={day.proofs.linkedin} disabled={isCompleted} onSubmit={handleSubmit("linkedin")} />
      </div>

      {!isCompleted && (
        <div className="mt-6">
          <CompleteDayButton proofsCompleted={proofsCompleted} onComplete={() => completeDay(day.dayNumber)} />
        </div>
      )}
    </Container>
  );
}
