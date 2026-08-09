import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
import type { DayProofs } from "@/lib/types";

/**
 * Merges class names and resolves conflicting Tailwind utility classes,
 * so components can accept a `className` override safely.
 */
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

function isValidHostUrl(value: string, host: string): boolean {
  try {
    const url = new URL(value.trim());
    if (url.protocol !== "http:" && url.protocol !== "https:") return false;
    const hostname = url.hostname.replace(/^www\./i, "").toLowerCase();
    return hostname === host && url.pathname.length > 1;
  } catch {
    return false;
  }
}

export function isValidGithubUrl(value: string): boolean {
  return isValidHostUrl(value, "github.com");
}

export function isValidLinkedinUrl(value: string): boolean {
  return isValidHostUrl(value, "linkedin.com");
}

export function countSubmittedProofs(proofs: DayProofs): number {
  return Number(proofs.github.submitted) + Number(proofs.linkedin.submitted);
}

export function formatShortDate(iso: string): string {
  return new Date(iso).toLocaleDateString("en-IN", { day: "numeric", month: "short" });
}
