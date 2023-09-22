import { defineConfig } from "astro/config";

import tailwind from "@astrojs/tailwind";

export default defineConfig({
  base: "/benchpress",
  markdown: {
    shikiConfig: {
      theme: "dark-plus"
    }
  },
  integrations: [tailwind({
    config: { applyBaseStyles: false },
  })]
});
