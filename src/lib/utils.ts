import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

let _thumbPattern: string | null = null;

export function thumbnail(url: string, width = 480): string {
  if (!url.startsWith("/uploads/")) return url;
  if (_thumbPattern === null) {
    const meta = typeof document !== "undefined" ? document.querySelector('meta[name="cms-thumbnail"]') : null;
    _thumbPattern = meta?.getAttribute("content") ?? `/api/cms/img/uploads/_probe?w=${width}`;
  }
  return _thumbPattern.replace("/uploads/_probe", url);
}
