<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter();

const userRole = ref('');

onMounted(() => {
  const userDataString = localStorage.getItem('dataUser');
  if (userDataString) {
    const userData = JSON.parse(userDataString);
    userRole.value = userData.user.role;
  }
});

const logout = () => {
  localStorage.removeItem('dataUser');

  router.push({ name: 'login' });
}
</script>

<template>
  <div class="w-full h-20 bg-white items-center justify-between p-6 flex">
    <div class="flex items-center">
      <h1 class="font-bold text-lg text-primary--500">MORENT</h1>
    </div>

    <div class="flex items-center justify-between ">
      <!-- Tampilkan tombol Add Car hanya jika role user adalah admin -->
      <RouterLink v-if="userRole === 'admin'" to="/add-car">
        <div class="flex w-[120px] items-center justify-center rounded-md p-3 bg-primary--500 cursor-pointer mr-14 pointer-click">
          <img src="../../assets/add-button.png" class="w-6 h-6 mr-2"/>
          <p class="text-sm font-medium text-white">Add Car</p>
        </div>
      </RouterLink>

      <div @click="logout" class="flex w-[120px] items-center justify-center rounded-md p-3 bg-white border border-primary--500 cursor-pointer mr-14 pointer-click">
        <p class="text-sm font-medium text-black">Logout</p>
      </div>

      <img src="../../assets/user.png" class="w-11 h-11 rounded-full"/>
    </div>
  </div>
</template>