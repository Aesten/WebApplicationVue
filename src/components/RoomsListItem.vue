<template>
  <div class="room border border-secondary rounded p-2 mb-2" :class="{expanded: isExpanded}">
    <div class="top-row d-flex" @click="toggleExpand">
      <div class="room-name fw-bold pe-3">{{room.name}}</div>
      <div class="room-floor text-muted">Floor: {{room.floor}}</div>
      <div v-if="room.currentTemperature != null" class="room-roomCTemp text-muted left-margin">Current temperature: {{room.currentTemperature}}</div>
      <div v-if="room.targetTemperature != null" class="room-roomTTemp text-muted left-margin">Targeted temperature: {{room.targetTemperature}}</div>

      <div class="expand-button ms-auto">
        {{ isExpanded ? '&#9660;' : '&#9658;' }}
      </div>
    </div>
    <template v-if="isExpanded">
      <hr/>
      <div class="details d-flex">
        <button type="button" class="btn btn-secondary me-2" @click="toggleRenameForm">Rename room</button>
        <button type="button" class="btn btn-danger enabled" @click="deleteRoom">Delete room</button>
        <template v-if="renameFormOpened">
          <room-rename-form class="form" @close-rename-room="handleRenameForm"></room-rename-form>
        </template>
      </div>
    </template>

  </div>
</template>

<script>
import axios from 'axios';
import {API_HOST} from '@/config';
import RoomRenameForm from "@/components/RoomRenameForm";

export default {
  name: 'RoomsListItem',
  components: {RoomRenameForm},
  props: ['room'],
  data: function() {
    return {
      isExpanded: false,
      renameFormOpened: false,
      selectedRoomId: null
    }
  }, 
  methods: {
    toggleExpand() {
      this.isExpanded = !this.isExpanded;
    },
    async deleteRoom(){
      await axios.delete(`${API_HOST}/api/rooms/${this.room.id}`);
      this.$emit('room-delete', this.room.id);
    },
    toggleRenameForm() {
      if (this.renameFormOpened) {
        this.selectedRoomId = null;
      }
      else {
        this.selectedRoomId = this.room.id;
      }
      this.renameFormOpened = !this.renameFormOpened;
    },
    async handleRenameForm(name) {
      let response = await axios.put(`${API_HOST}/api/rooms/${this.selectedRoomId}/rename/${name}`);
      let newRoom = response.data;
      this.renameFormOpened = false;
      this.$emit('room-updated', newRoom);
    }
  }
}
</script>

<style lang="scss" scoped>

.room {
  .top-row {
    cursor: pointer;
    text-align: left;

    .room-name{
      width: 200px;
    }

    .room-floor{
      width: 75px;
    }

    .room-roomCTemp{
      width: 200px;
    }

    .room-roomTTemp{
      width: 220px;
    }
  }

  .left-margin{
    margin-left: 20px;
  }

}


</style>
