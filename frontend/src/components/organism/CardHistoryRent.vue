<script setup>
import { useRouter } from 'vue-router';
import { defineProps } from 'vue';

// Mendefinisikan props
const props = defineProps({
    item: Object
});

const router = useRouter();

const rentNow = () => {
    // Mengakses item melalui props
    router.push(`/rent-car/${props.item.id}`);
};
</script>

<template>
   <div class="w-[304px] rounded-md bg-white p-4">
    <div class="flex items-center justify-between w-full ">
        <p class="text-lg font-bold text-black">{{ props.item.model }}</p>
        <p class="text-sm font-medium text-secondary--300">{{ props.item.brand }}</p>
    </div>
    <div class="flex items-center justify-between mt-6">
        <div class="flex items-center ">
            <img src="../../assets/calendar.png" class="w-6 h-6 mr-2"/>
            <p class="text-sm font-medium text-secondary--300">{{ props.item.start_date }}L</p>
        </div>
        <p class="text-sm font-medium text-secondary--300">-</p>
        <div class="flex items-center ">
            <img src="../../assets/calendar.png" class="w-6 h-6 mr-2"/>
            <p class="text-sm font-medium text-secondary--300">{{ props.item.end_date }}</p>
        </div>
    </div>
  </div>
</template>
