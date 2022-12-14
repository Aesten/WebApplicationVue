<template>
    <div class="box">
        <div class="cross" @click="closePopup">&#10006</div>
        <h1>Create Window</h1>
        <form @submit.prevent="submit" v-on:submit="createSection(name, roomId, status)">
            <input v-model="name" type="text" placeholder="Window Name" required><br>
            <div class="SelectLists">
                <p>Room</p>
                <select v-model="roomId" required>
                    <option v-bind:value="r.id" v-for="r in rooms">{{r.name}} </option>
                </select><br>
            </div>
            <div class="SelectLists">
                <p>Status</p>
                <select v-model="status" required>
                    <option>OPEN</option>
                    <option>CLOSED</option>
                </select><br>
            </div>
            <input class="submit-button" type="submit" value="Confirm Creation">
        </form>
    </div>
</template>

<script>
import axios from 'axios';
import {API_HOST} from '@/config';

export default {
  name: 'WindowCreateForm',
  data: function() {
    return {
        name: '',
        roomId: '',
        status: '',
        rooms: []
    }
  },
  created: async function() {
    let response = await axios.get(`${API_HOST}/api/rooms`);
    this.rooms = response.data;
  },
  methods: {
    async createSection(name, roomId, status) {
        let newWindow = await axios.post(`${API_HOST}/api/windows/`,
        {id: "null",
        name: `${name}`,
        roomId: `${roomId}`,
        roomName: "string",
        windowStatus: `${status}`}
        );
      this.$emit('close-create-window',newWindow);
    },
    closePopup(){
        this.$emit('toggle-popup');
    }
  }
}
</script>

<style lang="scss" scoped>
.box{
    border: solid black;
    background-color: #6c757d;
    border-radius: 30px;
    //margin: auto;
    padding: 30px;
    position: relative;


    .cross{
        position: absolute;
        top: 10px;
        right: 20px;
        cursor: pointer;
    }

    h1{
        font-size: 20px;
        color: #fefefe;
        font-weight: 600;
    }

    input[type="text"]{
        margin-top: 20px;
        margin-bottom: 20px;
        border-radius: 5px;

        &:focus {
          outline: solid green;
        
          &:invalid{
          outline:solid red;
          }
        }
    }

    select{
        &:focus {
            outline: solid green;
        
            &:invalid{
            outline:solid red;
            }
        } 
    }

    .SelectLists{
        display: flex;
        justify-content: center;
        align-items:baseline;

        p{
            margin-right: 10px;
            color: white;
        }
    }

}
</style>