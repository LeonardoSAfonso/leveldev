<template>
  <div class="container">
    <form class="row g-3">
      <div class="mb-3">
        <label for="title" class="form-label" style="">Titulo</label>
        <input type="title" class="form-control" id="title" aria-describedby="titleHelp" v-model="title">
      </div>

      <div class="mb-3">
        <label for="body" class="form-label">Body</label>
        <textarea type="body" class="form-control" id="body" aria-describedby="bodyHelp" v-model="body"></textarea>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">E-mail</label>
        <input type="email" class="form-control" id="email" aria-describedby="emailHelp" v-model="email">
      </div>

      <button @click="createPost" class="btn btn-primary">Create Post</button>
    </form>
  </div>
  <hr/>
  <h1>Posts</h1>
  <table class="table">
    <thead>
      <tr>
        <th scope="col">ID</th>
        <th scope="col">Title</th>
        <th scope="col">Body</th>
        <th scope="col">Email</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="post in posts">
        <th scope="row">{{ post.id }}</th>
        <td>{{ post.title }}</td>
        <td>{{ post.body }}</td>
        <td>{{ post.email }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script lang="ts">

import { defineComponent } from 'vue'
import api from '../http.ts'

interface Post {
  title: string,
  body: string,
  email: string
}

export default defineComponent({
  data() {
    return {
      posts: [] as Post[],
      title: String,
      body: String,
      email: String
    }
  },
  methods: {
    async loadPosts() {
      const response = await api.get("/posts")
      this.posts = response.data as Post[]
    },
    clearForm() {
      this.title = ""
      this.body = ""
      this.email = ""
    },
    async createPost() {
      await api.post("/posts", {title: this.title, body: this.body, email: this.email})
      this.clearForm()
      this.loadPosts()
    }
  },
  async mounted() {
    this.clearForm()
    await this.loadPosts()
  }
})
</script>