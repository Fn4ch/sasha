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
// Default CSS Reset and Base Styles
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

body {
  line-height: 1.4;
  font-size: 1rem;
  font-family: 'General Sans', Arial, sans-serif;
  background-color: $colorWhite;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: $colorBlack;
  min-height: 100vh;
}

.app{
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

*, *::before, *::after {
  box-sizing: inherit;
}

a {
  color: inherit;
  text-decoration: none;
  background: transparent;
  transition: color 0.2s;
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
  border-radius: 0.5rem;
  background-color: $colorOrange;
  color: #ffffff;
  transition: all 0.2s ease-in-out;
  padding: 1rem 1.5rem;
  text-align: center;
  &:active {
    scale: 1.02;
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
}
</style>
  