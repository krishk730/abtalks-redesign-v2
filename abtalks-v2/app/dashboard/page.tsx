import { Container } from "@/components/layout/container";
import { Card } from "@/components/ui/card";

export default function DashboardPage() {
  return (
    <Container className="py-8">
      <p className="eyebrow">Route · /dashboard</p>
      <h1 className="mt-3 font-display text-display text-ink">Dashboard</h1>
      <p className="mt-3 max-w-md text-body text-muted">
        Streak, today&rsquo;s task, 60-day progress, standing, and achievements will live
        here. This placeholder confirms the shared header and bottom navigation.
      </p>

      <div className="mt-8 grid gap-4">
        <Card>
          <p className="eyebrow">Current streak</p>
          <p className="mt-2 font-display text-display text-ink">—</p>
          <p className="mt-1 text-caption text-muted">Coming in the next step</p>
        </Card>

        <Card>
          <p className="eyebrow">Today&rsquo;s task</p>
          <p className="mt-2 text-body text-muted">Coming in the next step.</p>
        </Card>
      </div>
    </Container>
  );
}
