import * as React from "react";
import Link from "next/link";
import { cn } from "@/lib/utils";

type ButtonVariant = "primary" | "secondary" | "ghost";
type ButtonSize = "default" | "sm";

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
  size?: ButtonSize;
  /** If provided, renders as a Next.js Link instead of a <button>. */
  href?: string;
}

const variantStyles: Record<ButtonVariant, string> = {
  primary: "bg-accent text-white shadow-button hover:bg-accent-strong active:bg-accent-strong",
  secondary:
    "bg-transparent text-ink border border-border hover:border-ink/25 active:bg-ink/[0.03]",
  ghost: "bg-transparent text-ink hover:bg-ink/[0.04] active:bg-ink/[0.06]",
};

// default = 56px tall, sm = 44px tall — matches the 44–56px touch target spec.
const sizeStyles: Record<ButtonSize, string> = {
  default: "h-14 px-7 text-[0.9375rem]",
  sm: "h-11 px-5 text-[0.875rem]",
};

const base =
  "inline-flex items-center justify-center gap-2 rounded-pill font-sans font-semibold " +
  "transition-colors duration-150 ease-out disabled:opacity-40 disabled:pointer-events-none select-none";

export function Button({
  variant = "primary",
  size = "default",
  className,
  children,
  href,
  ...rest
}: ButtonProps) {
  const classes = cn(base, variantStyles[variant], sizeStyles[size], className);

  if (href) {
    return (
      <Link href={href} className={classes}>
        {children}
      </Link>
    );
  }

  return (
    <button className={classes} {...rest}>
      {children}
    </button>
  );
}
