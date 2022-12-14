<template>
  <div class="window border border-secondary rounded p-2 mb-2" :class="{expanded: isExpanded}">
    <div class="top-row d-flex" @click="toggleExpand">
      <div class="window-name fw-bold pe-3">{{window.name}}</div>
      <div class="room-name text-muted">{{window.roomName}}</div>

      <div class="open-status ms-4" :class="{open: isWindowOpen, closed: !isWindowOpen}">
        <template v-if="isWindowOpen">
          <span class="icon">&#x2B24;</span> Open
        </template>
        <template v-else>
          <span class="icon">&#x2716;</span> Closed
        </template>
      </div>

      <div class="expand-button ms-auto">
        {{ isExpanded ? '&#9660;' : '&#9658;' }}
      </div>
    </div>
    <template v-if="isExpanded">
      <hr/>
      <div class="details d-flex">
        <button type="button" class="btn btn-secondary me-2" @click="toggleRenameForm">Rename window</button>
        <button type="button" class="btn btn-secondary me-2" @click="switchWindow">{{ isWindowOpen ? 'Close' : 'Open' }} window</button>
        <button type="button" class="btn btn-danger enabled" @click="deleteWindow">Delete window</button>
      </div>
    </template>
    <template v-if="renameFormOpened">
      <window-rename-form class="form" @close-rename-window="handleRenameForm"></window-rename-form>
    </template>
  </div>
  
</template>

<script>
import axios from 'axios';
import {API_HOST} from '@/config';
import WindowRenameForm from "@/components/WindowRenameForm";

export default {
  name: 'WindowsListItem',
  components: {WindowRenameForm},
  props: ['window'],
  data: function() {
    return {
      isExpanded: false,
      renameFormOpened: false,
      selectedWindowId: null
    }
  }, 
  computed: {
    isWindowOpen: function() {
      return this.window.windowStatus === 'OPEN'; 
    }
  },
  methods: {
    toggleExpand() {
      this.isExpanded = !this.isExpanded;
    },
    async switchWindow() {
      let response = await axios.put(`${API_HOST}/api/windows/${this.window.id}/switch`);
      let updatedWindow = response.data;
      this.$emit('window-updated', updatedWindow);
    },
    async deleteWindow() {
      await axios.delete(`${API_HOST}/api/windows/${this.window.id}`);
      this.$emit('window-delete', this.window.id);
    },
    toggleRenameForm() {
      if (this.renameFormOpened) {
        this.selectedWindowId = null;
      }
      else {
        this.selectedWindowId = this.window.id;
      }
      this.renameFormOpened = !this.renameFormOpened;
    },
    async handleRenameForm(name) {
      let response = await axios.put(`${API_HOST}/api/windows/${this.selectedWindowId}/rename/${name}`);
      let newWindow = response.data;
      this.renameFormOpened = false;
      this.$emit('window-updated', newWindow);
    }
  }
}
</script>

<style lang="scss" scoped>

.open-status {
  .icon {
    position: relative;
  }

  &.open {
    color: #198754;
    .icon {
      font-size: 12px;
      top: -3px;
    }
  }

  &.closed {
    color: #dc3545;
  }
}

.window {
  .top-row {
    cursor: pointer;
  }
}
</style>
