import { CheckCircle2, Lock } from "lucide-react";
import { Button } from "@/components/ui/button";

interface CompleteDayButtonProps {
  proofsCompleted: number;
  onComplete: () => void;
}

export function CompleteDayButton({ proofsCompleted, onComplete }: CompleteDayButtonProps) {
  const isReady = proofsCompleted === 2;

  return (
    <div>
      <Button onClick={onComplete} disabled={!isReady} className="w-full">
        {isReady ? <CheckCircle2 size={18} strokeWidth={2.2} /> : <Lock size={16} strokeWidth={2.2} />}
        Complete Day
      </Button>
      {!isReady && (
        <p className="mt-2 text-center text-caption text-muted">
          Submit both proofs to unlock — {proofsCompleted}/2 done.
        </p>
      )}
    </div>
  );
}
