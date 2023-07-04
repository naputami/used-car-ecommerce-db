PGDMP         6                {            finalproject_pacmann    15.2    15.2 0    /           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            0           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            1           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            2           1262    17184    finalproject_pacmann    DATABASE     �   CREATE DATABASE finalproject_pacmann WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
 $   DROP DATABASE finalproject_pacmann;
                postgres    false            �            1255    17560 6   haversine_distance(numeric, numeric, numeric, numeric)    FUNCTION     B  CREATE FUNCTION public.haversine_distance(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
	rad_lat1 float := radians(lat1);
	rad_lon1 float := radians(lon1);
	rad_lat2 float := radians(lat2);
	rad_lon2 float := radians(lon2);
	
	dlon float := rad_lon2 - rad_lon1;
	dlat float := rad_lat2 - rad_lat1;
	
	a float;
	b float;
	r float := 6371;
	distance float;
BEGIN
	a := sin(dlat/2)^2 + cos(rad_lat1) * cos(rad_lat2) * sin(dlon/2)^2;
	b := 2 * asin(sqrt(a));
	distance := r * b;
	
	RETURN distance;
END;
$$;
 a   DROP FUNCTION public.haversine_distance(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric);
       public          postgres    false            �            1259    17502    ads    TABLE       CREATE TABLE public.ads (
    ad_id integer NOT NULL,
    user_id integer NOT NULL,
    car_id integer NOT NULL,
    description text,
    title character varying(50) NOT NULL,
    negotiable boolean NOT NULL,
    post_date timestamp without time zone NOT NULL
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    17501    ads_ad_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ads_ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ads_ad_id_seq;
       public          postgres    false    221            3           0    0    ads_ad_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ads_ad_id_seq OWNED BY public.ads.ad_id;
          public          postgres    false    220            �            1259    17522    bids    TABLE       CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    ad_id integer NOT NULL,
    bid_price integer NOT NULL,
    bid_date timestamp(0) without time zone NOT NULL,
    CONSTRAINT bids_bid_price_idr_check CHECK ((bid_price > 0))
);
    DROP TABLE public.bids;
       public         heap    postgres    false            �            1259    17521    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public          postgres    false    223            4           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
          public          postgres    false    222            �            1259    17495    cars    TABLE     �   CREATE TABLE public.cars (
    car_id integer NOT NULL,
    brand character varying(10) NOT NULL,
    model character varying(25) NOT NULL,
    body_type character varying(15) NOT NULL,
    year integer NOT NULL,
    price integer NOT NULL
);
    DROP TABLE public.cars;
       public         heap    postgres    false            �            1259    17494    cars_car_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cars_car_id_seq;
       public          postgres    false    219            5           0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
          public          postgres    false    218            �            1259    17470    cities    TABLE     �   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(50) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    17469    cities_city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cities_city_id_seq;
       public          postgres    false    215            6           0    0    cities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;
          public          postgres    false    214            �            1259    17481    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(30) NOT NULL,
    city_id integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    17480    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    217            7           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    216            |           2604    17505 	   ads ad_id    DEFAULT     f   ALTER TABLE ONLY public.ads ALTER COLUMN ad_id SET DEFAULT nextval('public.ads_ad_id_seq'::regclass);
 8   ALTER TABLE public.ads ALTER COLUMN ad_id DROP DEFAULT;
       public          postgres    false    220    221    221            }           2604    17525    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    222    223    223            {           2604    17498    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    219    218    219            z           2604    17484    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    217    216    217            *          0    17502    ads 
   TABLE DATA           `   COPY public.ads (ad_id, user_id, car_id, description, title, negotiable, post_date) FROM stdin;
    public          postgres    false    221   �7       ,          0    17522    bids 
   TABLE DATA           K   COPY public.bids (bid_id, user_id, ad_id, bid_price, bid_date) FROM stdin;
    public          postgres    false    223   �K       (          0    17495    cars 
   TABLE DATA           L   COPY public.cars (car_id, brand, model, body_type, year, price) FROM stdin;
    public          postgres    false    219   �f       $          0    17470    cities 
   TABLE DATA           I   COPY public.cities (city_id, city_name, latitude, longitude) FROM stdin;
    public          postgres    false    215   �h       &          0    17481    users 
   TABLE DATA           E   COPY public.users (user_id, name, phone_number, city_id) FROM stdin;
    public          postgres    false    217   j       8           0    0    ads_ad_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ads_ad_id_seq', 200, true);
          public          postgres    false    220            9           0    0    bids_bid_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.bids_bid_id_seq', 401, true);
          public          postgres    false    222            :           0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 1, false);
          public          postgres    false    218            ;           0    0    cities_city_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);
          public          postgres    false    214            <           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 100, true);
          public          postgres    false    216            �           2606    17510    ads ads_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ad_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    221            �           2606    17528    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public            postgres    false    223            �           2606    17500    cars cars_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 8   ALTER TABLE ONLY public.cars DROP CONSTRAINT cars_pkey;
       public            postgres    false    219            �           2606    17479    cities cities_longitude_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_longitude_key UNIQUE (longitude);
 E   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_longitude_key;
       public            postgres    false    215            �           2606    17544    cities cities_ltitude_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_ltitude_key UNIQUE (latitude);
 C   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_ltitude_key;
       public            postgres    false    215            �           2606    17475    cities cities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    215            ~           2606    17546    cars price_not_zero    CHECK CONSTRAINT     Y   ALTER TABLE public.cars
    ADD CONSTRAINT price_not_zero CHECK ((price > 0)) NOT VALID;
 8   ALTER TABLE public.cars DROP CONSTRAINT price_not_zero;
       public          postgres    false    219    219            �           2606    17548    users users_phone_number_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);
 F   ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_number_key;
       public            postgres    false    217            �           2606    17486    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            �           2606    17516    ads ads_car_id_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(car_id);
 =   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_car_id_fkey;
       public          postgres    false    221    219    3211            �           2606    17511    ads ads_user_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_user_id_fkey;
       public          postgres    false    3209    217    221            �           2606    17534    bids bids_ad_id_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_ad_id_fkey FOREIGN KEY (ad_id) REFERENCES public.ads(ad_id);
 >   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_ad_id_fkey;
       public          postgres    false    3213    223    221            �           2606    17529    bids bids_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_user_id_fkey;
       public          postgres    false    217    3209    223            �           2606    17489    users users_city_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_city_id_fkey;
       public          postgres    false    215    217    3205            *      x��]�n$Gr}������~�e����k~iI�Q{F�"}��D5��fVdOՐ��R*3.'N���!��=<���>><��tx8|�=�����_�;�չݏǿ��~����i���p�t������A>B���ȇ?��n?��w���0���������a�?�����ǟ������Q��|����x�ݞy䡔�W�0��^曧����ǟ��é�=Ϗ�_q�������������������I���s{���G?$9Iy>�7?=�~�<y�u3��n���s<�H�a�s��K	eC��^��?w�o/���xo�	Q��w��_��çχ�_��^�%�p�Q�S��4F<�����������yB�9��|�A�s6��SE<U�0�4�<��|�o�?~:<^ڰ��Α���c����#7΋1��#�yH<Ћw��å�$1�ސa�y�/�㯇�ߟv�|�Ծ#'�%^�эeif�~z<�zq�X�K�L{~>�[�~>���sq��>Ա�D�QB��,��θ�jX3����{X�b�x+o�N���
s>�Nӹ�W�$��9��r+r"�M���ǎw�а���,ĝxC�'���n$FZ8?S+/�Xz��z��A���x~&V�`�Gy 5��Y~8~�����+E
f,f˟�?�>w���x�p�}����d֋�	C�p�r�8�nfu�!I���!��ā�̄[��T\4��J�M�v�%QIz)�g������ۥ������r/o����y/a�ɥ��j�C|���>�d�Ċw��}��7R2�%�p�|&���w��	l�MX����&S��f��ȋU�6�)?�Έ|�od7�8�l�Xʡ�s�uEŸ���"���0��k����j]Q��JS/W�������W9��\�Y���Ǜ�Ò�M�Y��Qэ �8ʝD	��F���bZO�0��Q����p����5�`�{�[y�0H�:���&�u�q�8��i�9��3j�r5Qs���}t�LSy9��^ȑ����R=�cA|�kfq��}�\ĈC����xH!nň� ��B�@��TL+^AI �9��2�t~�V����C�۞J.hK�[̸��̫�,~Q�]���^����_��p#@ЍS��)���Z�ʳD���:��4�8��%���\9q���[�8��sN��=ų؏����/��p�d�b�)yz����]��ups
f@� �%�HE%gl!��ʃ��A�����,[rZ�_����>�6s�8%$�X��t����t�G��}���*��(.'�b�:��[�z�����P��13/����8��s	:�=�,��\u��ԉ��N'���d��T8�&7�9�\{��6��'�@�1��~r�e�v1��}mb���d�'� @�6&����t�/eb��x��1�9�|�T�KXl�%�T}pur&) �D��)�^�K߾��I��QsE�%8�((�����DLk. ��%�(Hb<q(4��?���M^Q��8x}�4�<ɭ�
Y'� �던9����Ep;�H6���EpT:2 y���r��y8'׫ ]�T�*�qn�.
��sC�����*�>����+2�X����贔��(�l۲[NX�JX�ތ�{.Ȟ���f!�}A�c���fL�w3�]�Un���,�6�r��Teq�K�s�%�f	��)�y���6]~_���ʢ��@��A���@�S�7���3�B)��DeoͺA���|-�4ӛ�0�yjC/&p�1��Ȫ���@oryE��g���v�C������}.lz������+rV,C� ���X��$0S�r9�݆9��I�Ŕϧ���� X���X1d��X��<u�s:Q��"k�)K
�vPf�f��6�ˉB'c�����@'��
��$����� ��RWкމ�;&?��xkǒb�^�(vp�J�����9W-�3�~ɪj�H�Ϩv��L/O�v�.\C^�y8�/����SI>�`^�dO����r�� =1�NV�ڡQrʮ��Y��,/c*��љ7C���N���g�m�Ky�{���g��M$�{��Ŗ�8�&Wznܣ���Lv�4��LS� ���3lb���ɸ�},c�Ar��(o^P��zn��*'�R�����,՛�N�E���X���2��� �8���Ƚ�����Ү#��`�R�u�j��;�������&��I ���(�#P�MSΕ��6@��Ty�y�	� �
r���+��
T b:�<r3��ۀ'H��>x0��՜ ܥޓ������A#�^R���!Q�7+r��ɥ�)nZ��R��xP�C�{q(CC�9�v��/���B�cA�F�;q�D��٢�m���(x���Qې�Y�J�pr������xj��Ǒ@���	5�E*]�p�U�w)���� 	�TP�=e��U��D�KT���K�����?A�yi����<ت�T�Z�-��(���y��-�\����h���TU
Ь�S�&�,%Q�ec8K�yֲ)z �0Dj
AН C�����
��]R#���u���6�N�R���V'���T��y���M�����r�ؗ���2�U���nv�|����nT;r��"��#y�N�Us��h�W���:EeQ�8���	P��r��.^
ͯ�)��X�N���4�3)�f\���P�UH��8���;�!˧6�OBE�W0�P3 �Y��,����6�'��%���<RQu�M�P�5M�K�i��@<�)e	,��ʙxj6&�����V���<��lX*c@/	�6�@%�Uj���Ǫ��k��u�)Ɂ�������#YZcs/u��X�}�9��9x����[��>�Ƀ6e���áؼ� ���Z��5�w"q��VK�YQ^]��M��r�8�p���/�C\�T�6��<�Kڬ�V~�!�m�����]�����"�)�9w�Vlѫ:5w��a���%�d���۲����S�QeƸ9%,�*���g��Fr�E���<�IN�۾�̋��4_oR�f�f�G9a"��*/��`�M��*꬧x9� P���+��G�/�M����0�j�䮕;b�M��	�����9�Л�$M_5b9ɶ	@�%�-��<�f��z&�k��:F�L<����cs�`}]'��h���a24�g�k��/��,+��"�:D嚦�O��wuSm3JHz;��`O�7!oJڛ��+uC����s%�vc8��4�4F����I6�4ت3\=yL�Ù��z� ��Aû$J�KfHN-���V�0%D`�U\0M���Ag+��a�|u�JH��v(;	�|�/���Jd�\����>f�<h�(.��lJ�<'[����]�V4���4I�=�*���̧5�����V_�]iZ�s#l�PN�L]�'�&��kI.F#1��hbg���wx��Z��p�:̅�-�o����]/�F���!p�;�S[G��٩^/"�690� %ɫ��<�l��� ���t���3.����>��te^k�Ԍh$���y�'[S�^�WT�!)��8�[��C"g�\[�Q�v��)���g�Dq�'�Y�>�r�X� �Ѵb�a�0XFˋ��l�[�y�����:�����}����SN���.����U�f#����y`�.�O�86��9SӦߺz#������t�_�釚�_��^����
�j�e{��]	+H���APNKI��lnw�������4�"FG$�F.I�iP��f֒j��Z4�/�{��D���e]�^���-�>JscJ?i����T��/^*s�~>�(("kҐ�����n;v�P���\��]Р�l�P�d��6�J�,�
a.�S$憯��_ץԪ9>#":8Y�[�$K(q�0��ԟ����@,(:m���%��d�+���};c���H��65QP������V�E��l��{,��Zm��2��r����Y�E��R�UaS[����Q�f�`�#��Z��c[�_��;�6�cR���w&���Q<5�o�@���N�-�,7�)v��s:m�
iz��� �  u�L��Pww痯W8e�zZ�E�oDk�qgG�:!�����sQp���8k��`��j�4fN*�D2��`.yh{T��� ������AK��+�B��U�uz�,��1���O'0u��k����� ��y<�<�k�*ug\�N��e�|H!$�.�4+���F���;���ӝ��B+��Եζ��.�k���",��Q�᦮@J:�mK��,l��"'R͜�2Ť���,x���Z�*�<�x��(��T��
�i�CDY�^��3Ĥ�"�l%��j4,Լ�����&U�]�-,_�/�ܡ�� d��&j������L���x$��L��$9�R�\�QQ[�O�]/������{LMB��lJ��/<� �(6*1�������Ó�Ve����1c���Y���m�䞀�0�%��j�	�c��1�7WG4�{(��h�6�el"�6)l�sd�P7�	��f?��C��
QasV��������Au��{
.�\�0:�,��[1�r�;	t����R���5)��f�k�(�{>t.�v6�L5�k�?�Ӳ+��WJ�N��K��tm;c�E��o�$��1��60�!أ?��u����0�������{�T��^��iz5�T�]���,� �����+��a���`���X��X��,������?D"��A����s�v4�4ܓ��R^�>/n퍺l�x�j�H��X�_aFj�W�o�]U�X�VQ�W'�'؃[�z#��@�4�I��$�r��$֜��[�c�ܖ�h(f�J�������![��e��v�˭�4^�X�2�#}1�ڏ?E��M�$Bժ�&�}�o6�����y�Pֈ2���]�^Y�x��*�Iw��ġZL&a�
n�Ֆ��f�vtV��i�z8u{�J�y��ׂ�c��͵l3�I�y�1UҙB��r����S&)��il�l�x��c0�ƥ�_{�E-*�fP<� I`��O�8�?p���      ,      x�][[��6��.�bO��%��5���8. ږ*���H��HV��}���Y�hu���e��_��o��>��8�V�ϙ���_)�_+��T�����Xş�W۷�o�W�4��9�Cx_-�|����S��>F�������}#���t~:>��p��ܧ:?��o[�:���S����m��T����p�^xP�ƌ�+��gŷ�Ƶ>�����Z,���򯷫X����Vlۡ���gźj�8nȧ����e���}�_������֣���0F�o+߂c��6�y�1��Ợ��OUkt����W��Η\>�x����]���σ�싣�K��xV��lcU���E24j�����	Fٴ���Co�Ie�ڇ���*�����������	�k���$�y�+0n��/+t�
ؤۊ��c���t"�%�e���i���tj�}�b���>�kv�b �������q����ժ�����
ip�F�%z��=���'$2��9W��~WA-��i3�ZkX�q��+�[��qK~�nي���\;�i���9����D����}mFSd� 8f]����'���� ���F��;�U���	�����|��(��ӐHq_���G�m\v���/D��pvx_�ǥ� / ���
�͘60��C�;�-���zke�1�f�b''ź�3ep�4��
�������;0+�1�0n�Z컐���x[o:��c1�:0b�	�s|�]��q�E���/5� gd)>��4+�� �`�Xc����q}�ĳ�V����L�ëG)�k����D�<���K�z;:�a�̹`7�n�f���+��R�ļ>�8�
�����6ִ)�Ƿ��������~�զ��$��P�l��n��!��4�^u��eot�Pq{�(�m�s
v���HAZW4N�r��e�TVf�7�ପͥZ������a�&+)�b�~^Ok����A� �㨼�IHm��`Mb�A����<���u� !܀t�����<��!�;����&G����xOk3֛Ո�b����yp�F��V��Ŝ,I��vC �r� dN�$���@Ǳ*#a)Ѣ�Qޏ�[��Bt<h(��%��|YH.r��HǓ� gPo^���RQ�Wo
M
P��7��bS�vu�@	�&u�7XW������Z{�[W�>�ԫe c$� ���] .�]��@��F�ek��8���A�їr���g���$�@���  �ݏl5��m�λ����������aBr,�YB�R����M]�N��IqcF ��Gѩ�<c��C���1l�=��-<�L�@�H�+��u\S�" & �]1,�1��#6�A JT��$�/pE�䰐#�N|ݼ����'{�+@[���'� �lcaBab}x�*�MKP��8�����TI:���U	�n����2��'A�dU�9�H2�;*u����%���0`	�֚��PE�k}J��k���n@>���R�T!�k�&^�ʤ��8����T��0�i���k�I�͂!1h�,B�E�j;]�oV���aHL<}��s��T��ŭ@F53뾩T#�%� }�y ������,c-�pG��}����Z�E.WB�r����CDw�z��C���Op�]�EI�B����:�!Tey�f�>�sҍk1��3�R����P��ic����U���{R��"��oF�ԭ��,�H��Z�K$�*�����/��2/�IO�a୾��51�(�pE"���T;�9���y�{H� �����yf ��DL�@��h��,���M�$,A����K����R�T� 3 �a�3�sV�
�;�}3N��U)Z;�&=��@����+�ڋh�L��q]�T��e��%6�n�\��R�����eR�7��Q�A��

6>`�7�_7�e��k�*%m�Q���V�y�G�3��	*�q�1�w�<�p�oT� �h�:�R�L�%��X):�܉ġ�I�anK�@n@����[~��{�aYP����D�v"'2CO�U�(��▝�o�#X^���B����.T�5a�~59�3��4P(a�bq��(�+�*�`�"= :ӛ�Sx)%*���b���:���@�,f"CP�Тw �ؼ8�#(e.�&c�6p��B��/�f� ZA,��:��
?���jt���G�k��ц�j'���A��.���A�7]y1T�˧��?�����huqm��`���_�8u�G���k���}n�ѝ���e��٣Q������!�(zh��z@����0�|3����R����H`i@���Lq�Pkl���\R��� �֍�a���U�=*Hr;�A7=R�poH��8�)�+T�d��i�x\Q��,쵉s�8 �<Z3�7���[x����X��	���f@e��2۠��h	���U����j��v;��J�T���k����TU/V\��:~�w��9�X�ܭȌ�z`������K2����H�Q��� )�"$X>�AU�[���S�R�ভR�,"�h�og��О�-!?�;
���ˆ��k�mܢ��ʹ �G�P	dQ�qo<� �'$���ЭC}I�PU�||Z*��go��n�fA��Y��jH�����{�8�ղ1E� ~�"�I$MJ�Q�2�P�;�]E"����i���`��+�$�_�h��A�<�X��04�1�V笠l0�"�X�#Qu�a��#E#NSw��s��cw��M��? ����_�J�����e� �-����p~�" ���@@����?�i�T�8Jd��y��� '���(@�[�oNܤf�n�s��)p������PS��K�M*u��7���X��QT��ʏ�b��7�ad!D l�j!�{�U&9��j�y�4W�!�v�p�lf�{�C���WJ`*l$0�:)BU9�����!�P!@��X/��&���c�Xjc�T����f N*f�躛{7^��I�'�,��.#. [�=�v'�&j��l+I�;��~���A������P{�a�)W��lv���G%L�NT����e��3��Qs�B �-0lLD��@�2�	g������L�a��� ��`��v��'jqX��Az�(�	Ie�J���ҕ�D^) ��A�pU֩3�s��6�'��g�d��1{˚`�U֓O�0�Y�rX�-1i� �g�CU���s�8T���i1���`�*/��J*t_>9��\gg�"��N�ڜ������H�x��q�6�P=�ZC�(?)�s��0��v����$ܱrX9 >�v,�_J\��z�ƶ�|�����:��R��� 9�(8X�43K6"fi�3��M�X$Y{��-0 ��]���2��I=��!�v�&1�{�j	���T�����Шԟ�� ��!��w���=�s�{lw)W�,ʀz��$��v�9��C "J}�U�t��m啣7}����Ȣ٢���9���G���(}�6My��$�g̈́Hzq��H$dU��$60O��z �sġ����.�@�F�ih��b�&�R�����ˈ��9���D�9:��v�rة��Fcku�X،q�GQ4@6�='��i!�Y͸���U�,����c̕��H��S	�b�d��k������h�1o-}��U�E��svK�&�~Vt;ݦ�%�1+��4�Ǫ�rl�i�GፖA�����iiT�s�Fq�1�_��^n3�� �XK���h��(��������pT��9W4%�s-r�bap�6v�a�_EA������ya�#$3�r���گ�cN|C�1qn��$�B�Yo��.��3�����yW!����a@ua	�޽������)^��oK���A:�sƃ2��%���ߤ1ɪZ_8��%
���=Fr�&a�"�=g"�k!7�^(�n���h���1v/��q�L>��߶(aG���e�u �
  ��̵��R��`��s.��I�;�p_s�N�Fz��-�HN�n1b�y�e�k%�堒-�X�m@%��f���OF�����iB͡���Вj5n2q�ڞ�k���g�s�!h���J��g�cA4���� 8	��ҡ9��v���q��v�j�Q��q�!2슄�MdئҨD���e;�}T?7�ު����A�9l;*l΅4�a���J�0 �e
�`�f D�{Y�C�ڱ'3$qI7T:��_@��8nb��w�r�ՅG�r ?�\C�)�t[��n�Dζ�����/l*7��Y�ų=G�n~ 깎FuK���.��}�!��-� ��rb�&"����Tj�]@�G��W�t��4�J��DD5�P`����!������S����^���%�����jD���lj꺹��r�힭�ڪ?��Ȥ(0��%��aʽg�[��L8|�x�nG�ﶾ�Q��&pl>>r3ҭ���T�1J�!se�ÿ���b�R����X55��h��3-�x�"��rj\�i��Rg������Qf�tl+-��sv~q�fV0��:��$AQ��n����S�~��kGa0�À�����F��x����}%��,��-�+ܖ$k��r����;ٱ{��&�B�qΑ�_���t������=� ��p����\�w�x�4�6�=+2���\�㶡���������Z ���ͪ|X�uXn��T깜�h ���X1H�J�e�#-��|������N��.�P�L%G�Yf��0A"�o��ȢW���|�:���#ju0L��.M!R��/"4�?�v�a����Mm�B�p/j�6I�e��w�3�����Ơ��΀�.��8�\�P�I�Ҡrp�q�r9$�����gI������.�n�h=�b��:1�&[��l�k�V���(�Q�Ɩ�I� �I>Wn4�G �ؾ0��a@0�V���z�7b��IâE`�q����]ܲ���4r���l�F�[��]L�s���3�Ň�|�Y�o�w��։3�Y�vۉP�Z/��eۄ�88nmk��fN�t�|SI[� R5?�-Um3�N'����7����Z@d�eK��{]{=N�K��u��E�����*{k��'j3�b�VV��M�ʧ�ŀ�����d��Ye@p���	wU�Y��	�ruh��,FM#\njRH?;���n�g���'�M�X�y����y���d��"�����_͚SE| e�ݯ���O��kT5�{&�WiQ�?[z�|<*LBd�)̐2O�Y���^�m���hڻ�3�ݽ��\�9��o#;��A�b�b���V��:^4VsJ��ə����;T�b��J�Ie[�t'%�f��4�|��<:Ȅ��������C���>��4[��i�����*o��T
W��"x�ǭZ~�G��Ha5{��P���Mx� �'7W��q9gt�����2�ܘ�J<DC�7�r�W��[H_�FJ�D�\�D(POkǂ�rliC�j7�mXE��k��~7^yn��>��F���n��88�r��	h�s�2Ğ��h�&>/���ɰ%�zv 6$H�&���Y6;�ԋ�i�ׅC�|jxDY
�p֓�+I�;sK�f�g'a;�H�� �[�w��h�_��XX�'�Bˢ9�X8�1s��#¹�*6���+j��-©��� A�Fys.	�	�,��]R����n�߃HQ�x� �*���f��L|��͂��Ev2I��w�tS�4�h�r�n�-����%�,W��
�u��	���U��i�z�Y
��&d�2R�1ۉ霕j�E�Z}>��U�c[9{Z��&%�*/���,���o��iøN����	Xx��Y�[-J�{��sM�,C�˗�B��j��Cv�]�g���d�k��5=�X�g&�ɶ�,����cn��O��pciف�q�;k����pf��Ŭ�M����89.,u�a�;妥���+~��ɒ:@���|��%������l���N�s��Xxh�~&}�iVH�;��w0�$c��wS�9En7pA��}�'f���u��#�!N������
�w{fZ��bouC\J��͞���m[�u�|Q׭�-{O �ܜ�6~��r�/�"abMY���,An��ɞJja/���gDjy1r���!�~�n�xH��'J%r�?���uc�T�V�k��q�R&{�<�w�cXs���-ƌ���m�j֒��D���6�����R�DSv�dd��I���M_�!���xZ�����D�9-ZK�B���7G�ޫ��3���ks�u
�n�az���]LϡjBI_���>�pi�fƇ������y0U��q��P۲�z"����N��}�ރ�ͯ�o���9�;�
�2]Ǝ3@D�Җqo[�U  I����X�Qq�&�?�#���o�YƮ��J�̷�v��n�ZcA�%Lv����KA�SN��l0W�;�����\���q��n3ù$ +s�=[2 �x�B���!+;ݚ��uu��HO���-ĵ�稯��=������E�7��m�0��I<�c�87c����}m.���<�"�Z���<$��T�p��\��� ��k��.E�r����m��y_"j�nj��1��9X��~��_��[��Q3�4��Cd�\�i[�ըla��&����z+�*������L?��u��5,f�b��x�ʵ��њ���r���ɢ��H+E"�.�`h�0�8rX8XŊD���m�}�$$���u�?�B       (      x����j�@��GO�Hٝ��N 
%N�r�q�#,�O�~�N흍��Z�B��7�9sfW�}���5�����v���o�BZ�Έ��2�%㪌k���8
�D�ʔ�#H�	��z��m:��L�"�!��"LC��;�h$�Ɯ�XIQl�y�e��w��e�J��8{X�(�Yvؖ�n���!xβ�b�5X���k�nv���z��e�^q�UAF�V��)1,W�Q�	�9�K�
ʞ��źn60��x:z2�ڡNb�iH>���"N�-O���`�/�?�U��O��Ӿ���Q�v��m�&�*��m���K�՗j���L`Z�]�z����{<�ܤ�'�� @�u�rg�;�lh���V� +
�3l[�����3m���p1Jg�_���{;�	�Y@���b@�
>m�ng4�?�yw�*�]c=[���M&�@���H�g?ZH�-���@�;�0�vouzMn��z��B�,���,r�Q��mF� �g�ʈ� ˟��oUU�BTj�      $   b  x�U��j�0����G3��aO[�����̒LR78�!oߑ���	��ͧ�3v�ߓ��cG��6_l�^4b�T�C�X8A����L6ڂ	˂sNH�a~��k2���KrzƻϓM64� ��ƽ�4.�����ǆIS��R��{���l8t/9ւ�����
pSeU�y��v��TT]\�ĵN����>\��M暉Z"D����}�Ɔ��k��rr9*x���7�/� VX�a� ���ě��OS?}��VDW�^6}4�ة?���ֈ�Ϫ��7C�n�v�;�����";���_O~t���/�U�_c���1��|�<��ߟ��W��R�ӠD"�ZÿB�Ot�)      &   �  x�]W�r9<�_�c+���}9ʻ,˭�2���dr$�dQQU�B�����L8l����LHv~�2�f�=��m��_.�W�N�?��G\H����i��B���6����1O�.�q�MН�>2g�\hv�;m׉Iۼ+�N�!�=�>��E�iO�0��>�r�χ4����D��JϽ���؅e�ÔS�/��~w���v��~Vx���L[�]�~2NV9��S���O���}�	�E'��Dp�0�.��d;&~z�=}��w]�u'm脉�Vػ�\�K���}+���p"J&5���ð�b��S�׏)��1��1�'�����Ԧ���ͣ���p뼥��BJv�͛��Oy�� �Ɲ��
� �T�u��6l�����s��}��2�,�������Q��#7����a_S���q�42t�V���NZ�=i�q���C�n#u�K�]��l�ؗ%����4桮���N�Cp�V�]�n�tp� �y�o�@�O~��:Y�g�+pW|�C��~6F���@�B#��zK��}��˓�\	Լ������*����1cϫ��i� %��	�0�1Jv���2���yJ��iW�ت�T�A����˪�i�;�e+A�]ϖ���-mY82Wbl�7���)�P�Z'Blʏ�ZET�wڋ�e�izڦy�A9�i|�S��.�C@�C�3M���/R���ٗ�%�\1/�͘��}+e��h[W��
艉�͡o����*���X�� �x�1.��8�I'A-TPz��2�q2>W�Y���hc�BK�{��t)G�`M|�|A������2����I����)u;Z��������_@@V��j�7����N"m�6���w %�8������6����.<Y��Eu�3�_a�0�_΂��O�B+2��ՙ����1~y:<��Vɚ��GiL%���j)D�u��6]�t{�w]������ �2V��n�Б�+��<�c�2��y4R��XD�d�3�:�ϐ^(GWzB� ����@SO�2��J��ox����;/�l�(�h'��{=Kj�^E�y��T�*����燡= R�����}E~u�vC�煑�8R-��X�>M����p�����^C��%d����,D��l��*��=��i��p��wi|��ڠ^�|��M`WKN.����J��\�s���.��]�>7������nh�g���Ҭ�
���J�P�`�f�b?�[��1s
��3��lUc͏Öu(<8���4,�(~���4��w VvR�&�ְi��`Z.�o����j��#���ZQk��H��#��	�a'�]��]���=����)�̗��������5����7G���-F	���6H=�����4�d�P�3�ȴ��Q��붳��H�q�~���I�<���Y6&��w�∨�n=�Hw$���~��C�j	}/���<�,!��}��{����dm[�<�SWk���a=o��B���S�fUΰ�����~@�fbɢUZs- u��x�i}SB!a2�5G	W�H�. ��)� ���<�
+����r��++��GhD�5ނ�W���Sڵ���!����s��A��C�im��:\G�Y{>"I���[\D@��kL-�J���!�.�Ҁ�	�W}�$�
S R�0�"F^���zq;���wQT��4S������y"�1x>��4 �~�E��敆�($)�+{�>���ג眦I��.us�)ϖ��� ���,M�
;Z��=U��@\(@�,%�h������W��|3��� �e� �E������J>r���-���}ڀ�P�G�q^��B�!�'ƫ�%��m�IY@;[*'� �dV�H^�0w�!��R CF�0��yI�����+14!H�kM	��J-�Q�v��w�C�������nʎƺ��sS���ɯV�a�V�^@5Ri�I`'ØV�]q<����A�b��ݪ<�(�����ř�����]�I�Q�g��0��G%�ø��cx�!���@��as�H+��ږ��b�a^'���~�����\��tMS����}�˵��B���
6\� �O���^^Ͻ�j�Ӂ���E��7	�*�fd�b ����x>cZ�:.�)�^�01�gg�:�*��,���YJ1�R`@�E'[�l�
00*�K T�|��c��=*�sp1�2]mfyp��e-oi� ;MY�������Sy)     