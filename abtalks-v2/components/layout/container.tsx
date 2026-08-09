import * as React from "react";
import { cn } from "@/lib/utils";

export function Container({ className, children, ...rest }: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div className={cn("mx-auto w-full max-w-app px-4 xs:px-5 lg:px-8", className)} {...rest}>
      {children}
    </div>
  );
}
