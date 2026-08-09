import * as React from "react";
import { cn } from "@/lib/utils";

type BadgeVariant = "neutral" | "accent" | "positive" | "negative";

interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> {
  variant?: BadgeVariant;
}

const variantStyles: Record<BadgeVariant, string> = {
  neutral: "bg-ink/[0.04] text-muted border border-border",
  accent: "bg-accent-soft text-accent-strong border border-accent/20",
  positive: "bg-positive/10 text-positive border border-positive/20",
  negative: "bg-negative/10 text-negative border border-negative/20",
};

export function Badge({ variant = "neutral", className, children, ...rest }: BadgeProps) {
  return (
    <span
      className={cn(
        "inline-flex items-center gap-1.5 rounded-pill px-2.5 py-1 text-[0.6875rem] font-semibold leading-none",
        variantStyles[variant],
        className
      )}
      {...rest}
    >
      {children}
    </span>
  );
}
