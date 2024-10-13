<script setup>
import { ref } from 'vue'
import TopBar from '../molecule/TopBar.vue';
import CardAds1 from '../organism/CardAds1.vue';
import CardAds2 from '../organism/CardAds2.vue';
import CardCatalog from '../organism/CardCatalog.vue';
import { reactive, onMounted } from 'vue';
import axios from 'axios';
import CardOnGoingRent from '../organism/CardOnGoingRent.vue';
import CardHistoryRent from '../organism/CardHistoryRent.vue';


defineProps({
  msg: String,
})

const state = reactive({
  items: [],
  onGoingRent : [],
  historyRent : [],
  isAdmin: false,
  searchBrand: '',
  searchModel: '',
  isSearch: false,
  selectedFilter: 'all',
});

const userDataString = localStorage.getItem('dataUser');
const userData = JSON.parse(userDataString);
const userId = userData.user.id;

if (userData.user.role === 'admin') {
  state.isAdmin = true;
}
const currentTab = ref('search');
const selectTab = (tab) => {
  currentTab.value = tab; // Update the current tab
};
const initData = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/cars');
    const carsAvailable = await axios.get('http://127.0.0.1:8000/api/cars/available');
    const onGoingRentCar = await axios.get(`http://127.0.0.1:8000/api/ongoing-rental/${userId}`);
    const historyRentCar = await axios.get(`http://127.0.0.1:8000/api/history-rental/${userId}`);

    console.log(historyRentCar)
    state.searchModel = '';
    state.searchBrand = '';
    state.items = response.data.data;
    state.carsAvailable = carsAvailable.data.data;
    state.onGoingRent = onGoingRentCar.data.data
    state.historyRent = historyRentCar.data.data
    state.isSearch = false;
    await filterRentalData()
  } catch (error) {
    console.error(error);
  }
};
const searchCars = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/cars/search', {
      params: {
        brand: state.searchBrand,
        model: state.searchModel,
      },
    });
    if(state.isAdmin){
      state.items = response.data.data;
    }else{
      state.carsAvailable = response.data.data;
    }
    state.isSearch = true;
  } catch (error) {
    console.error(error);
  }
};
const filterRentalData = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/rental', {
      params: {
        filter: state.selectedFilter
      },
    });
    state.rental = response.data.data;
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  initData();
});
</script>

<template>
  <div class="items-center justify-between pb-10">
    <TopBar/>
    <div class="mt-20 px-28">
      <div v-if="state.isAdmin">

        <div class="flex mt-4">
          <button @click="selectTab('search')" :class="{'bg-primary--500 text-white': currentTab === 'search', 'bg-gray-200': currentTab !== 'search'}" class="px-4 py-2 rounded-l-md">Cars</button>
          <button @click="selectTab('rental')" :class="{'bg-primary--500 text-white': currentTab === 'rental', 'bg-gray-200': currentTab !== 'rental'}" class="px-4 py-2 rounded-r-md">Rental Data</button>
        </div>

        <!-- Tabel untuk Admin -->

        <div v-if="currentTab === 'search'">
          <div class="w-full mt-10 h-20 bg-white items-center justify-between p-6 flex">
            <div class="flex items-center w-full">
              <h1 class="font-bold w-[10%] text-lg text-primary--500">Search Cars</h1>
              <div class="h-10 w-[80%] rounded-md ml-4 rounded-full p-3 items-center justify-between flex border border-slate-400  mr-2">
                <input v-model="state.searchBrand" class="w-full font-medium text-sm text-slate-400 ml-4 outline-none" placeholder="Search by Brand..."/>
                <input v-model="state.searchModel" class="w-full font-medium text-sm text-slate-400 ml-4 outline-none" placeholder="Search by Model..."/>
              </div>
              <button @click="searchCars" class="bg-primary--500 text-white p-2 rounded mr-2">Search</button>
              <div v-if="state.isSearch">
                <button @click="initData" class="bg-red-800 text-white p-2 rounded">Clear</button>
              </div>
            </div>
          </div>
          <table class="min-w-full bg-white">
            <thead>
            <tr class="w-full bg-gray-200">
              <th class="py-2 px-4 text-left">Brand</th>
              <th class="py-2 px-4 text-left">Model</th>
              <th class="py-2 px-4 text-left">Plate Number</th>
              <th class="py-2 px-4 text-left">Daily Rate</th>
              <th class="py-2 px-4 text-left">Stock</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="item in state.items" :key="item.id">
              <td class="py-2 px-4 border-b">{{ item.brand }}</td>
              <td class="py-2 px-4 border-b">{{ item.model }}</td>
              <td class="py-2 px-4 border-b">{{ item.plate_number }}</td>
              <td class="py-2 px-4 border-b">{{ item.daily_rate }}</td>
              <td class="py-2 px-4 border-b">{{ item.stock }}</td>
            </tr>
            </tbody>
          </table>
        </div>
        <div v-if="currentTab === 'rental'">

          <div class="w-full mt-10 h-20 bg-white items-center justify-between p-6 flex">
            <div class="flex items-center justify-between w-full">
              <h1 class="font-bold w-[10%] text-lg text-primary--500">Rental Data</h1>
              <div class="ml-4 flex items-center">
                <select v-model="state.selectedFilter" @change="filterRentalData" class="border border-slate-400 rounded-md p-2">
                  <option value="all">All</option>
                  <option value="ongoing">On Going</option>
                  <option value="history">History</option>
                </select>
              </div>
            </div>
          </div>
          <table class="min-w-full bg-white">
            <thead>
            <tr class="w-full bg-gray-200">
              <th class="py-2 px-4 text-left">Brand</th>
              <th class="py-2 px-4 text-left">Model</th>
              <th class="py-2 px-4 text-left">Plate Number</th>
              <th class="py-2 px-4 text-left">Rent By</th>
              <th class="py-2 px-4 text-left">Start Date</th>
              <th class="py-2 px-4 text-left">End Date</th>
              <th class="py-2 px-4 text-left">Return ?</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="item in state.rental" :key="item.id">
              <td class="py-2 px-4 border-b">{{ item.brand }}</td>
              <td class="py-2 px-4 border-b">{{ item.model }}</td>
              <td class="py-2 px-4 border-b">{{ item.plate_number }}</td>
              <td class="py-2 px-4 border-b">{{ item.name }}</td>
              <td class="py-2 px-4 border-b">{{ item.start_date }}</td>
              <td class="py-2 px-4 border-b">{{ item.end_date }}</td>
              <td class="py-2 px-4 border-b">{{ item.is_return === 'true' ? 'Yes' : 'No'  }}</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div v-else>
        <div class="w-full mt-10 h-20 bg-white items-center justify-between p-6 flex">
          <div class="flex items-center w-full">
            <h1 class="font-bold w-[10%] text-lg text-primary--500">Search Cars</h1>
            <div class="h-10 w-[80%] rounded-md ml-4 rounded-full p-3 items-center justify-between flex border border-slate-400  mr-2">
              <input v-model="state.searchBrand" class="w-full font-medium text-sm text-slate-400 ml-4 outline-none" placeholder="Search by Brand..."/>
              <input v-model="state.searchModel" class="w-full font-medium text-sm text-slate-400 ml-4 outline-none" placeholder="Search by Model..."/>
            </div>
            <button @click="searchCars" class="bg-primary--500 text-white p-2 rounded mr-2">Search</button>
            <div v-if="state.isSearch">
              <button @click="initData" class="bg-red-800 text-white p-2 rounded">Clear</button>
            </div>
          </div>
        </div>
        <div v-if="!state.isSearch">

          <div class="mt-20 px-28">
            <h1 class="font-bold text-lg text-primary--500">On Going Rent</h1>
            <div class="items-center justify-center flex mt-12">
              <div class="flex grid grid-cols-4 gap-4 items-center justify-center">
                <CardOnGoingRent v-for="item in state.onGoingRent" :key="item.id" :item="item" />
              </div>
            </div>
          </div>

          <div class="mt-20 px-28">
            <h1 class="font-bold text-lg text-primary--500">History Rent</h1>
            <div class="items-center justify-center flex mt-12">
              <div class="flex grid grid-cols-4 gap-4 items-center justify-center">
                <CardHistoryRent v-for="item in state.historyRent" :key="item.id" :item="item" />
              </div>
            </div>
          </div>
          <!-- Kartu untuk Pengguna -->
          <div class="mt-20 px-28">
            <h1 class="font-bold text-lg text-primary--500">Available Car for Rent</h1>
            <div class="items-center justify-center flex mt-12">
              <div class="flex grid grid-cols-4 gap-4 items-center justify-center">
                <CardCatalog v-for="item in state.carsAvailable" :key="item.id" :item="item" />
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          <div class="mt-20 px-28">
            <h1 class="font-bold text-lg text-primary--500">Available Car for Rent</h1>
            <div class="items-center justify-center flex mt-12">
              <div class="flex grid grid-cols-4 gap-4 items-center justify-center">
                <CardCatalog v-for="item in state.carsAvailable" :key="item.id" :item="item" />
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

