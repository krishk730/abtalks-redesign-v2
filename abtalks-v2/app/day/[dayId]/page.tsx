import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";

export default function ChallengeDayPage({ params }: { params: { dayId: string } }) {
  return (
    <Container className="py-8">
      <p className="eyebrow">Route · /day/{params.dayId}</p>
      <h1 className="mt-3 font-display text-display text-ink">Day {params.dayId}</h1>
      <p className="mt-3 max-w-md text-body text-muted">
        The task brief and the Understand → Build → GitHub Proof → LinkedIn Proof →
        Complete journey will live here.
      </p>

      <Card className="mt-8">
        <p className="eyebrow">Proof health</p>
        <p className="mt-2 text-body text-muted">0/2 proofs complete — coming in the next step.</p>
      </Card>
    </Container>
  );
}
