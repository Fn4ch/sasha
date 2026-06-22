<template>
  <div class="app">
    <AppHeader />
    <NuxtPage />
    <AppFooter />
  </div>
</template>
  
<script setup lang="ts">
import AppHeader from '~/src/widgets/AppHeader.vue'
import AppFooter from '~/src/widgets/AppFooter.vue'


</script>

<style lang="scss">
@use "@/assets/styles/_vars.scss" as vars;

:root {
  --header-height: 96px;

  @media (max-width: 1440px) { --header-height: 85px; }
  @media (max-width: 1024px) { --header-height: 80px; }
  @media (max-width: 480px)  { --header-height: 70px; }
  @media (max-width: 375px)  { --header-height: 65px; }
  @media (max-width: 320px)  { --header-height: 60px; }
}

// Material Design CSS Reset and Base Styles
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
  box-sizing: border-box;
}

// HTML5 display-role reset for older browsers
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
  display: block;
}

html {
  overflow-x: hidden;
  // Material Design typography
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, Arial, sans-serif;
}

body {
  line-height: 1.6;
  font-size: 1rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, Arial, sans-serif;
  background-color: #fafafa; // Material Design background
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: rgba(0, 0, 0, 0.87); // Material Design text color
  min-height: 100vh;
  overflow-x: hidden;
}

.app{
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  overflow-x: hidden;
}

*, *::before, *::after {
  box-sizing: inherit;
}

a {
  color: inherit;
  text-decoration: none;
  background: transparent;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1); // Material Design easing
}

a:focus, a:active {
  outline: none;
}

img, picture, video, canvas, svg {
  display: block;
  max-width: 100%;
  height: auto;
}

button, input, select, textarea {
  font-family: inherit;
  font-size: inherit;
  line-height: inherit;
  color: inherit;
  background: none;
  border: none;
  outline: none;
}

button {
  cursor: pointer;
  border-radius: 4px; // Material Design border radius
  background-color: $colorOrange;
  color: #ffffff;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  padding: 0.75rem 1.5rem;
  text-align: center;
  font-weight: 500;
  text-transform: uppercase; // Material Design button style
  letter-spacing: 0.5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); // Material Design shadow
  
  &:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transform: translateY(-1px);
  }
  
  &:active {
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    transform: translateY(0);
  }
  
  &:focus {
    border: none;
    outline: none;
  }
}

h1{
  font-size: 4rem;
  color: white;
  background-color: transparent;
  font-weight: 300; // Material Design typography
  letter-spacing: -0.5px;
}
</style>
  