"use client";

import * as React from "react";
import { Github, Linkedin, CheckCircle2, ExternalLink, AlertCircle } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { cn, isValidGithubUrl, isValidLinkedinUrl, formatShortDate } from "@/lib/utils";
import type { ProofKind, ProofState } from "@/lib/types";

interface ProofFormProps {
  kind: ProofKind;
  proof: ProofState;
  disabled?: boolean;
  onSubmit: (url: string) => void;
}

const KIND_META = {
  github: {
    icon: Github,
    label: "GitHub proof",
    placeholder: "https://github.com/you/repo/commit/...",
    helper: "Link your repo, commit, or pull request for today.",
    invalidMessage: "That doesn't look like a github.com link yet.",
    validate: isValidGithubUrl,
  },
  linkedin: {
    icon: Linkedin,
    label: "LinkedIn proof",
    placeholder: "https://www.linkedin.com/posts/...",
    helper: "Link the post where you shared today's build.",
    invalidMessage: "That doesn't look like a linkedin.com link yet.",
    validate: isValidLinkedinUrl,
  },
} as const;

export function ProofForm({ kind, proof, disabled = false, onSubmit }: ProofFormProps) {
  const meta = KIND_META[kind];
  const Icon = meta.icon;

  const [isEditing, setIsEditing] = React.useState(!proof.submitted);
  const [value, setValue] = React.useState(proof.url ?? "");
  const [error, setError] = React.useState<string | null>(null);

  const showForm = isEditing && !disabled;

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const trimmed = value.trim();

    if (!trimmed) {
      setError("Paste a link before submitting.");
      return;
    }
    if (!meta.validate(trimmed)) {
      setError(meta.invalidMessage);
      return;
    }

    setError(null);
    onSubmit(trimmed);
    setIsEditing(false);
  }

  return (
    <Card>
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Icon size={17} strokeWidth={2.1} className="text-ink" />
          <p className="font-display text-heading text-ink">{meta.label}</p>
        </div>
        <Badge variant={proof.submitted ? "positive" : "neutral"}>
          {proof.submitted && <CheckCircle2 size={12} strokeWidth={2.5} />}
          {proof.submitted ? "Submitted" : "Pending"}
        </Badge>
      </div>

      <AnimatePresence mode="wait" initial={false}>
        {showForm ? (
          <motion.form
            key="form"
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.18 }}
            onSubmit={handleSubmit}
            className="mt-3 overflow-hidden"
          >
            <p className="text-caption text-muted">{meta.helper}</p>
            <input
              type="url"
              inputMode="url"
              value={value}
              onChange={(e) => {
                setValue(e.target.value);
                if (error) setError(null);
              }}
              placeholder={meta.placeholder}
              className={cn(
                "mt-2 h-12 w-full rounded-card border bg-bg px-4 text-body text-ink placeholder:text-muted/70",
                "focus:outline-none focus:ring-2 focus:ring-accent/40",
                error ? "border-negative" : "border-border"
              )}
              aria-invalid={Boolean(error)}
            />
            {error && (
              <p className="mt-2 flex items-center gap-1.5 text-caption text-negative">
                <AlertCircle size={13} strokeWidth={2.2} />
                {error}
              </p>
            )}
            <div className="mt-3 flex gap-2">
              <Button type="submit" size="sm">
                Submit {kind === "github" ? "GitHub" : "LinkedIn"} link
              </Button>
              {proof.submitted && (
                <Button type="button" variant="ghost" size="sm" onClick={() => setIsEditing(false)}>
                  Cancel
                </Button>
              )}
            </div>
          </motion.form>
        ) : (
          <motion.div
            key="submitted"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.18 }}
            className="mt-3"
          >
            {proof.submitted && proof.url ? (
              <>
                <a
                  href={proof.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-1.5 text-body text-accent-strong underline decoration-accent/30 underline-offset-4"
                >
                  <span className="truncate">{proof.url}</span>
                  <ExternalLink size={14} strokeWidth={2.2} className="flex-none" />
                </a>
                {proof.submittedAt && (
                  <p className="mt-1 text-caption text-muted">Submitted {formatShortDate(proof.submittedAt)}</p>
                )}
                {!disabled && (
                  <Button type="button" variant="ghost" size="sm" className="mt-3" onClick={() => setIsEditing(true)}>
                    Update link
                  </Button>
                )}
              </>
            ) : (
              <p className="text-body text-muted">Not submitted yet.</p>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </Card>
  );
}
