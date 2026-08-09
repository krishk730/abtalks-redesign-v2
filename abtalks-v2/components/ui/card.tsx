import * as React from "react";
import { cn } from "@/lib/utils";

interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  padding?: "default" | "compact" | "none";
}

const paddingStyles: Record<NonNullable<CardProps["padding"]>, string> = {
  default: "p-5 xs:p-6",
  compact: "p-4",
  none: "",
};

export function Card({ className, padding = "default", children, ...rest }: CardProps) {
  return (
    <div
      className={cn(
        "rounded-card border border-border bg-surface shadow-soft",
        paddingStyles[padding],
        className
      )}
      {...rest}
    >
      {children}
    </div>
  );
}
