"use client";

import { motion } from "framer-motion";
import { PartyPopper } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

interface CompletionPanelProps {
  dayNumber: number;
  currentStreak: number;
}

export function CompletionPanel({ dayNumber, currentStreak }: CompletionPanelProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 8 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3, ease: "easeOut" }}
    >
      <Card className="border-accent/25 bg-accent-soft/60 text-center">
        <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-surface">
          <PartyPopper size={26} strokeWidth={2} className="text-accent-strong" />
        </div>
        <h2 className="mt-3 font-display text-heading-lg text-ink">Day {dayNumber} complete</h2>
        <p className="mt-1.5 text-body text-muted">
          You&rsquo;re on a {currentStreak}-day streak. See you back here tomorrow.
        </p>
        <Button href="/dashboard" className="mt-5 w-full">
          Back to dashboard
        </Button>
      </Card>
    </motion.div>
  );
}
