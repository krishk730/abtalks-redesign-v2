import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

export default function LandingPage() {
  return (
    <Container className="py-10 sm:py-16">
      <p className="eyebrow">Route · /</p>

      <h1 className="mt-3 max-w-lg font-display text-display-lg text-ink">
        Ship something,
        <br />
        every single day.
      </h1>

      <p className="mt-4 max-w-md text-body-lg text-muted">
        This is the landing page foundation for ABTalks — a 60-day build-in-public
        challenge for Indian college students. Full marketing content arrives in the
        next step.
      </p>

      <div className="mt-8 flex flex-wrap gap-3">
        <Button href="/dashboard">Start the challenge</Button>
        <Button href="/day/12" variant="secondary">
          Preview a challenge day
        </Button>
      </div>

      <Card className="mt-10 max-w-md">
        <p className="eyebrow">Foundation check</p>
        <h2 className="mt-2 font-display text-heading-lg text-ink">Design system online</h2>
        <p className="mt-2 text-body text-muted">
          Warm neutral background, near-black text, one careful orange accent, editorial
          display type, rounded 20px cards, and soft 1px borders.
        </p>
      </Card>
    </Container>
  );
}
