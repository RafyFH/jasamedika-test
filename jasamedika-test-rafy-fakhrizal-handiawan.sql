PGDMP                   	    |            rent_car    16.4    16.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16455    rent_car    DATABASE     �   CREATE DATABASE rent_car WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Indonesian_Indonesia.1252';
    DROP DATABASE rent_car;
                postgres    false                      0    16456    cars 
   TABLE DATA           �   COPY public.cars (id, brand, model, plate_number, daily_rate, available, created_at, updated_at, gas, driving_type, capacity, stock) FROM stdin;
    public          postgres    false    215   u
                 0    16465    rentals 
   TABLE DATA           }   COPY public.rentals (id, user_id, car_id, start_date, end_date, total_amount, created_at, updated_at, is_return) FROM stdin;
    public          postgres    false    217   �
       
          0    16473 
   return_car 
   TABLE DATA           Z   COPY public.return_car (id, rentals_id, plate_number, created_at, updated_at) FROM stdin;
    public          postgres    false    219   �
                 0    16479    users 
   TABLE DATA           q   COPY public.users (id, name, address, phone, license_number, created_at, updated_at, password, role) FROM stdin;
    public          postgres    false    221   �
                  0    0    cars_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.cars_id_seq', 12, true);
          public          postgres    false    216                       0    0    rentals_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.rentals_id_seq', 19, true);
          public          postgres    false    218                       0    0    return_car_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.return_car_id_seq', 18, true);
          public          postgres    false    220                       0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 23, true);
          public          postgres    false    222                  x������ � �            x������ � �      
      x������ � �         J   x�32�LL����46242 �b�(##]C]CcCc+s+cS=S#sC3|RA�i�@�&z�b���� ©|     