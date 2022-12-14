<template>
  <button class="button-add-room btn btn-secondary me-2" @click="toggleCreateForm">Create room</button>
  <div class="room-list pt-3">
    <rooms-list-item
      v-for="room in rooms"
      :room="room"
      :key="room.id"
      @room-delete="deleteRoom"
      @room-updated="updateRoom"
    >
    </rooms-list-item>
  </div>
  <template v-if="createFormOpened">
    <room-create-form class="form" @toggle-popup="toggleCreateForm" @close-create-room="handleCreateForm"></room-create-form>
  </template>

</template>


<script>
import axios from 'axios';
import {API_HOST} from '@/config';
import RoomsListItem from './RoomsListItem';
import RoomCreateForm from "@/components/RoomCreateForm";


export default {
  components: {
    RoomsListItem,
    RoomCreateForm
  },
  name: 'RoomsList',
  data: function() {
    return {
      rooms: [],
      createFormOpened: false
    }
  },
  created: async function() {
    let response = await axios.get(`${API_HOST}/api/rooms`);
    this.rooms = response.data;
  },
  methods: {
    deleteRoom(id){
      let index = this.rooms.findIndex(room => room.id === id)
      this.rooms.splice(index,1)
    },
    updateRoom(newRoom) {
      let index = this.rooms.findIndex(room => room.id === newRoom.id);
      this.rooms.splice(index, 1, newRoom);
    },
    toggleCreateForm() {
      this.createFormOpened = !this.createFormOpened;
    },
    handleCreateForm(newRoom){
      this.createFormOpened = false;
      this.rooms.push(newRoom.data);
    }
  }
}
</script>


<style lang="scss" scoped>
.button-add-room {
  margin-top: 20px;
}

.form{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
