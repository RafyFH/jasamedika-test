import { createRouter, createWebHistory } from 'vue-router'
import Home from '../screens/Home.vue'
import Login from '../screens/Login.vue'
import Register from '../screens/Register.vue'
import AddCar from '../screens/AddCar.vue'
import RentCar from '../screens/RentCar.vue'
import EndRentCar from '../screens/EndRentCar.vue'

const isAuthenticated = () => {
    return !!localStorage.getItem('dataUser');
}

const getUserRole = () => {
    const user = JSON.parse(localStorage.getItem('dataUser'));
    return user?.user.role || null; // Assuming 'role' is stored in the 'dataUser' object
}

const routes = [
    {
        path: '/login',
        name: 'login',
        component: Login
    },
    {
        path: '/register',
        name: 'register',
        component: Register
    },
    {
        path: '/',
        name: 'home',
        component: Home,
        meta: { requiresAuth: true }
    },
    {
        path: '/add-car',
        name: 'addCar',
        component: AddCar,
        meta: { requiresAuth: true, requiresRole: ['admin'] }
    },
    {
        path: '/rent-car/:id',
        name: 'rent-car',
        component: RentCar,
        props: true,
        meta: { requiresAuth: true, requiresRole: ['pengguna', 'admin'] }
    },
    {
        path: '/end-rent-car/:id',
        name: 'end-rent-car',
        component: EndRentCar,
        props: true,
        meta: { requiresAuth: true, requiresRole: ['pengguna','admin'] } // Only 'admin' can access this route
    },

]

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes
})

// Global navigation guard
router.beforeEach((to, from, next) => {
    const isAuth = isAuthenticated();
    const userRole = getUserRole();

    console.log(userRole);
    if (to.meta.requiresAuth && !isAuth) {
        next({ name: 'login' });
    }
    else if (to.meta.requiresRole && !to.meta.requiresRole.includes(userRole)) {
        console.log(to.meta.requiresRole.includes(userRole) );
        alert('Access denied!');
        next(false);
    }
    else {
        next();
    }
});

export default router;