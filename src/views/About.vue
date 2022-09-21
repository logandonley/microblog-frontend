<template>
  <div class="about">
    <h1>This is an about page</h1>
    <p>Base API url: {{env}}</p>
    <p>Build Environment: {{build_env}}</p>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      env: process.env.VUE_APP_BASE_API_URL,
      build_env: process.env.VUE_APP_BUILD_ENVIRONMENT
    }
  }
}
</script>
