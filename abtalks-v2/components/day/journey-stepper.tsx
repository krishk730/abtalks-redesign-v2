"use client";

import { BookOpen, Hammer, Github, Linkedin, CheckCircle2 } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

interface JourneyStepperProps {
  hasAnyProof: boolean;
  githubDone: boolean;
  linkedinDone: boolean;
  isCompleted: boolean;
}

const STEP_META = [
  { key: "understand", label: "Understand", icon: BookOpen },
  { key: "build", label: "Build", icon: Hammer },
  { key: "github", label: "GitHub", icon: Github },
  { key: "linkedin", label: "LinkedIn", icon: Linkedin },
  { key: "complete", label: "Complete", icon: CheckCircle2 },
] as const;

export function JourneyStepper({ hasAnyProof, githubDone, linkedinDone, isCompleted }: JourneyStepperProps) {
  const passed = [true, hasAnyProof, githubDone, linkedinDone, isCompleted];
  const currentIndex = passed.includes(false) ? passed.indexOf(false) : passed.length - 1;

  return (
    <div className="flex items-start" aria-label="Challenge day progress">
      {STEP_META.map((step, index) => {
        const isDone = passed[index] && index !== currentIndex;
        const isCurrent = index === currentIndex;
        const Icon = step.icon;

        return (
          <div key={step.key} className="flex flex-1 flex-col items-center">
            <div className="flex w-full items-center">
              <div
                className={cn(
                  "h-px flex-1",
                  index === 0 ? "opacity-0" : isDone || isCurrent ? "bg-accent" : "bg-border"
                )}
              />
              <motion.div
                initial={false}
                animate={{ scale: isCurrent ? 1.08 : 1 }}
                transition={{ duration: 0.2 }}
                className={cn(
                  "flex h-8 w-8 flex-none items-center justify-center rounded-full border",
                  isDone && "border-accent bg-accent text-white",
                  isCurrent && !isDone && "border-accent bg-accent-soft text-accent-strong",
                  !isDone && !isCurrent && "border-border bg-surface text-muted"
                )}
              >
                <Icon size={14} strokeWidth={2.3} />
              </motion.div>
              <div
                className={cn(
                  "h-px flex-1",
                  index === STEP_META.length - 1 ? "opacity-0" : isDone ? "bg-accent" : "bg-border"
                )}
              />
            </div>
            <span
              className={cn(
                "mt-1.5 text-center text-[0.625rem] font-medium leading-tight",
                isCurrent || isDone ? "text-ink" : "text-muted"
              )}
            >
              {step.label}
            </span>
          </div>
        );
      })}
    </div>
  );
}
