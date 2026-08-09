"use client";

import { Flame } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

interface StreakFlameProps {
  streak: number;
  size?: "default" | "lg";
}

export function StreakFlame({ streak, size = "default" }: StreakFlameProps) {
  const isActive = streak > 0;
  const iconSize = size === "lg" ? 40 : 28;

  return (
    <div className="flex items-center gap-3">
      <motion.div
        initial={{ scale: 0.85, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ duration: 0.35, ease: "easeOut" }}
        className={cn(
          "flex items-center justify-center rounded-full",
          size === "lg" ? "h-16 w-16" : "h-12 w-12",
          isActive ? "bg-accent-soft" : "bg-ink/[0.04]"
        )}
      >
        <Flame
          size={iconSize}
          strokeWidth={2}
          className={isActive ? "fill-accent text-accent" : "text-muted"}
        />
      </motion.div>
      <div>
        <p
          className={cn(
            "font-display leading-none text-ink",
            size === "lg" ? "text-display" : "text-heading-lg"
          )}
        >
          {streak}
        </p>
        <p className="mt-1 text-caption text-muted">day streak</p>
      </div>
    </div>
  );
}
