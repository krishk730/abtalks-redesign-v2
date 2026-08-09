import { CheckCircle2 } from "lucide-react";
import { Badge } from "@/components/ui/badge";

interface ProofHealthBadgeProps {
  completed: number;
  total?: number;
}

export function ProofHealthBadge({ completed, total = 2 }: ProofHealthBadgeProps) {
  const variant = completed === total ? "positive" : completed > 0 ? "accent" : "neutral";

  return (
    <Badge variant={variant}>
      {completed === total && <CheckCircle2 size={13} strokeWidth={2.5} />}
      {completed}/{total} proofs complete
    </Badge>
  );
}
