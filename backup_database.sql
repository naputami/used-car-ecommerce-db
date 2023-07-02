PGDMP                         {            finalproject_pacmann    15.2    15.2 0    0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    17184    finalproject_pacmann    DATABASE     �   CREATE DATABASE finalproject_pacmann WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
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
       public          postgres    false            �            1259    17502    ads    TABLE     i  CREATE TABLE public.ads (
    ad_id integer NOT NULL,
    user_id integer NOT NULL,
    car_id integer NOT NULL,
    description text,
    title character varying(50) NOT NULL,
    color character varying(10),
    mileage_km integer,
    transmission character varying(10),
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
       public          postgres    false    221            4           0    0    ads_ad_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ads_ad_id_seq OWNED BY public.ads.ad_id;
          public          postgres    false    220            �            1259    17522    bids    TABLE     �  CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    ad_id integer NOT NULL,
    bid_price integer NOT NULL,
    bid_date timestamp(0) without time zone NOT NULL,
    bid_status character varying(10) NOT NULL,
    CONSTRAINT bids_bid_price_idr_check CHECK ((bid_price > 0)),
    CONSTRAINT bids_bid_status_check CHECK (((bid_status)::text = ANY ((ARRAY['Sent'::character varying, 'Rejected'::character varying, 'Accepted'::character varying])::text[])))
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
       public          postgres    false    223            5           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
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
       public          postgres    false    219            6           0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
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
       public          postgres    false    215            7           0    0    cities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;
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
       public          postgres    false    217            8           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    216            |           2604    17505 	   ads ad_id    DEFAULT     f   ALTER TABLE ONLY public.ads ALTER COLUMN ad_id SET DEFAULT nextval('public.ads_ad_id_seq'::regclass);
 8   ALTER TABLE public.ads ALTER COLUMN ad_id DROP DEFAULT;
       public          postgres    false    221    220    221            }           2604    17525    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    222    223    223            {           2604    17498    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    219    218    219            z           2604    17484    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    217    216    217            +          0    17502    ads 
   TABLE DATA           �   COPY public.ads (ad_id, user_id, car_id, description, title, color, mileage_km, transmission, negotiable, post_date) FROM stdin;
    public          postgres    false    221   -9       -          0    17522    bids 
   TABLE DATA           W   COPY public.bids (bid_id, user_id, ad_id, bid_price, bid_date, bid_status) FROM stdin;
    public          postgres    false    223   RQ       )          0    17495    cars 
   TABLE DATA           L   COPY public.cars (car_id, brand, model, body_type, year, price) FROM stdin;
    public          postgres    false    219   �m       %          0    17470    cities 
   TABLE DATA           I   COPY public.cities (city_id, city_name, latitude, longitude) FROM stdin;
    public          postgres    false    215   �o       '          0    17481    users 
   TABLE DATA           E   COPY public.users (user_id, name, phone_number, city_id) FROM stdin;
    public          postgres    false    217   eq       9           0    0    ads_ad_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ads_ad_id_seq', 200, true);
          public          postgres    false    220            :           0    0    bids_bid_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.bids_bid_id_seq', 401, true);
          public          postgres    false    222            ;           0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 1, false);
          public          postgres    false    218            <           0    0    cities_city_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);
          public          postgres    false    214            =           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 100, true);
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
       public          postgres    false    219    221    3212            �           2606    17511    ads ads_user_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_user_id_fkey;
       public          postgres    false    3210    221    217            �           2606    17534    bids bids_ad_id_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_ad_id_fkey FOREIGN KEY (ad_id) REFERENCES public.ads(ad_id);
 >   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_ad_id_fkey;
       public          postgres    false    3214    223    221            �           2606    17529    bids bids_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_user_id_fkey;
       public          postgres    false    217    3210    223            �           2606    17489    users users_city_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_city_id_fkey;
       public          postgres    false    215    3206    217            +      x��]]�Gn}���nP���7�	�l`d{�	�����7���,-`���ﴺ�,OK+�M�r��"yx�1~Ha�_oo_߮�~~������O�w�~�����@͹���{u��ͷ�?_/_�^���|����������_o�ׯ~xs���o�������������߷�Ͽ�o����oo��4�s�<L҆w��DO��(]<]���4�:�f�WBj��>{���/�w��-Rn{�~���t̗/޼��v��?���|��o&�D��"j��Y����Źk�W_�0dV�.�}����۷[})[�����Un��A�n�.?��8��u�C��s�r������W�2����>���+�~����寷޼��D�r���ŗ��הǄ��nQ��߿~~��F�S)�D��~`-��p��A�뷝p۱�1�(�E���������Z�O�hڎ&�����￯Ԝ>j�+5�{�O.�3�R�&?>�������w�>��O���iM������ۻ_�_>���������:�n6�tMn�C�+����w�?n4M�S�i��Ϣ�ނ�S��(��]\��x�mlC����1��-��8Ǧ�Ϥ�^,|V��'
׮x�4��ઃ�"��9����E�>�G��� ?���5��ϏŴ�B�Xx�ʋ|�rs˳a�XE�������=%�������(�R흢vӳ~�=OA���I\�0����
~����_��^t�ь3dYt�|����?=_�����n�/���0}� �7/���s�!9A~�q�py���Ӊ�J�w�����)2��8E�E�4P[ًf��K�)>j+�5��}�v�B��5�����꒿x~w�ek&�Ez�_p���H�*Ǯ�]���]���'�����/�X����Wl9��\\���^{���;C|	*_�z{�ޱo�����	��(�2�ܭ�0�`����	���UtV]����7x*6�n[�oՌOT���Hnhi�ž�\b<�$���J|����Յk�#?�`5�i�ܬӬ�Y��4�~���ͯ^^N�EoO��p����0ǖ��Q�����Q�3����u�耾)�|v�#K�S��Z5d�2������������/y�H��a䯁!m)��TTQ�nl�t�Q�pFa��Ŀ�<�]7�b a�Z!�j��r��k�3-���hF���B���H�������v�6'�l�j��Rd�X18 1����RvM��@ϱ\��4���%����K��=�cwS>foh�D����EO�Z�+���J β�a�iC�e��l2��s���O��W��'�=���>���~����(������	�mgVS�����N �%�8��@ł�%S��!w�K�SQNr��"[���O�eS��XgI�x;��Spb:M����$�m��<򃈾�l�r4C����l2����4��cL�iK�˶C c�P�C<��|�>-APdom�AGA2/0�(]k�6n�,��%�+�=��dH#G���Y�b��>��[�Z$�I`��D��|�E�D�$}N���6�#�r����|��;v����<f$b�]/���V!���y�������ZZ�=����G>A��$D;��(r�,q+t�$0��T<�B�@�R�ꄱ�c�<PY ;C���h�8G��UX����א�� H1F�љW���d�(��� �*a�2�2V��AƏ�r@��^ж��p�D�	�tE���
�jȯ9���-�"93"F�r��E���Ye�n֍������WN\�=���i*�:pq<"uϑ�(�� ���VVY��c��n'2��-B�>H�y� �(�;k��DF+=��0k�xC��+n�d1��ǩ w(�jRɮ�:�GnyE��j�l��cq�q���V^G���9�Sng	��ʑ6�k���l3���G[�����l�YE��e" 2�(W���8��0�fղ�(�ʸT�YR�+�I=�ô��j2�|�f���D�T��XX% 	��e]�Qk�~�|I?W,!u�@�!D�NQ�9:<#�n�`(GNr�� ^d)|�����a��"�8Z=$F KU}I�?eT��G�jճR����4���+iA�ZB�l��kL(�2��R4�J%��<N�LXGoM:�~@�v����
�)� ;]�l�1+��N|����J	�O!2��F��������>���b1{����^�%��|��cC��gXQ�(C��
kS������E�VI����1�QJ.�r����c��	"u��+JԀ����99@��텃T�1(ׁa,"X�/jKE�CdXG飄��0}�Y�.N7)'�ay���x���к]e.���C�(P��r̀�R�b��W͘��y�����|�����(���q���62��C�\\��#�D�����{�����I�<CB4KF�z[Uj�U���`Cfp/#�Ř�R�iu��qT�K=���"��a������w��h�K�h��E�V-�^6-��5ձ���N��Y���a�ax�#�J����CE�v!�o�.��=G~��z� _QT�q GA���S��J�լ��N��L�=g]���ҥ��#�7/Q��R1��:n�� @k+Z��IG��4�?)�|��Ґ�/ZJ#�$��2h:N�B$+�(�֔ЧP2xp�����]Y^�%��я�x���|����u �+��/�Q$�m��3C9�?�l:�D��K)�b[����E��+���Wr�N� ّǻ�:I��Ƿ-{5��(?r���g��E��k���Cd�RU�ح�A\�ԯ��FF�i�ʏ�<���<ι��������}���<���]|�ZK_��8�z˵89	���v��q*�1�.Q~�iJ`ъ�M�Q�&�:#�����(������Q"\��P≯r
cM�1e7��J�(��K��}���:�2ؽ��v'RN�K���(^z�(���/�Oɂl��R_�,�?*~�`�l0��DGN��!ϖ�5�n�Jj�BϤ%��U�*Zz�ɱ�s��q�)���9�{�n�m ^9��Du���M�����E����9���m1vY��]S�GG�]nȵ�@��� �z�`yC�;��:��Zv�n�9S\�k���Y� �1��C8~�N�J�X��F�(X�pHV��Ik�y�Fh��>d|N���̛�bΜD@�Z�tBjȁ��$0�j�H��Ԉs��f?.2�����͆���&-����UGˢ�C^����r�,+��Z,�����������6d���T1�s�+�2�b3�ҙ��vtas��P���h��[�wgP�B"'����U��)Թ��zK���87�r��	+_3Y)whŸ�vPG\�0ߗDPx'�lά��}۱��?m��%qؘ�r�,Um���	V�!G�޲[y��/5X5���L�C��E?i�֏ƪ3�gǿ�MN�Q�877C�V� 1%��p89*�J{Ɵ�u��)r�^8�$��ca�P�L0�����4P��/x��T'��3�
�!&�Z���)�P��*������Lߡx�tfFm�՛&�x���� и�z֡�U{��J�m���)�J��ԡ�`�`��;����p����v�s�쟀t5=����r���v3��s��í�ei.�`�!��1<�XI�Qp˜�^f����2,\m�DTN�y�}���S�N@��� ��Pf����'�A��6GѨ3!u��h�`��d���GB��{�|H�:��Ad���!�e��apx�W��"�٨��,����҄p�^=T���Te0!eG�މ�~B6"y�I9I�+�W0w�Л�j�r��d.�F��h���K�y����{�=��t��'�3B��e�p�V��|0Ƿ���^[�D�A��H���\��( ��h���{�aK� �����Ha��̀����f��k(Ԩ�U)�,XC��hA�N����\W3\Z����ke�Xh,�:W;5JM�y�Њ��|d�OTb�{�"]��l�q�#<� j�	��殇�����F��	!w�!S�E��NS%����9.���N�ܹVPEiG���)�m��ދ�f� ��2   D����Ed���I&4�����O�]/�H�����?IH~�w:-��L;7�����k'ћ���mX#i�1��϶��� ��E�>'Db]�&��18�	v�f"��f���"XY�Fp�)���A L�(��>�7�3�VFy�P LGHve5��LT�(�õ�U��,fR�)���^�u�n�:�e�T�պJ�#	\pҺ�L}�;��=�R6�=���&K�<��P�
B��˽f��!�B�lu��5�!�����4$*&u��V�fC�he���Y{�?���;�3��S�f���8�K��s�ٖ�PdA��~��Nm]�ɰf�E���{ �Hh+�aji&3>s��;�����<{�Ld�=�	��;����j�T���˧nǜ	 H�/�sr��Ȁ�#{\�\�'Ȳ���B���	d��ܕ�;�Z>rP*�N��Hx�x�@T�=��U�y���� JCf��>�^I�D!p���p��H�xz,�d=#��`���~��ao7g:%��7�SB�)�,a'rءޒB��<���;᳐*���		a"!��R�T]���1vj��`}=��� ��7����}6]��Da���}���*�Ҽ��C����ʩ��6Ș�p�w�H�����l�j��5�if������h3J�LN�x��	z�
��$-�8$�|�d7X���1���в���K����:m/��Ibc��ǉЗP��YZ�r�Y����p�'���hS�(wk�6)u��+�{bJ�g��FA�lܭ�~˹fϾ?��V��G|@�.�'s��]p&��Hʼ�"�XSg�Jj�;����Qz�l'�	��	��D�<]x���j¡P}�+ Xx5� HU�9�O��΢�=������Y��`'�<mO������q�
*�6�������F}������U;�dnd�v�u˖nטt��� �EC��iH�g��/:1s�p̥����aW���v��V`+�z)��$#�nk��;��w)���-	#rh�������T��#㳫�h} [�����ޒa��+�E%�
��)ɖ�U�Xe5�|�8��O�[�n�.�^��#�f�l������(��'�nbj��ʵ�)�!��t}�'K=v�0�"`�=諯BHv]���aY~�[���$8*VI�:ܚ������«A�2��iH�MvǙ,j�V,�s�Mx����}� V�K��(����.��Q�Ĳ�yq3d�N2kΩ"���l��fjuZg�I:�"ZgQ'�
�?YK!�:�2��cQ?R�'�<Vz����v�r������-�\*$��C��a��j�w�on�{prYy�j�.�6X��F�Y��P���k�6L��N�C�ҊD�#��/�Z޿�7��"��$; [�F��X�c����Ǚ��]^r.�C���Yaf/IzS�ݙ�o�C�>ڄi/K_X�>;ӄ����;6����a��F�k�e�}&Q@N��v��jdָOͳ�,D+˲� YNE�@�۹ޛ�)�n�Z��*unY���-q�X��ݙ��=���t�@��AV����G�]����%F{W����5q��_�	�
�a�7�{ū��}�S\���j��j�Lر���Lݤ6�`&�O����t&�r�����u au���So�LŻ ������͝͹b�5r�"�g�Yڐ7���;yE��e�0N�������/5��~��E��^?I�	]�����7�a��{�Љ��y��S/�������z��:'��bp.+[v:��O�`+��o���ǖ��
�Ꚁ؂������@�9����*�@M:9�/����Sg��G�m�X��g������JJ��Cw�J���"0��(dU�.0�j���0�HW�N���ScCKHf;�1�C�ȗ�]�׫�M�/I�mڷ,�t����VM��L۩��_�DE����`E�?��R�������?@'H�� �_��;�����&��=�e������+�n��m�.eW��A��D�>3)3LA���]aT$�yX�旖���/�����K2�
E�fpɁ��i��{A�)      -      x�e\K�-9n�Z���sH��g�-�S��o�Ã��2%�UwuGttf�D� ȼ���)�G��Y>��~��~��}k�����������c����L�����+՟���-����qm������u}�?�'�o���>���~���˧�Z}�}5���ON�<���������bc~r��z�3֕��1�֊��+��O���Y�rJϥ�K��[�7���������֬���YҊqG>o�G'�^�����_���o�����Km�=�s������^�G�焝�L����%�پ��3�^�z͜?���K�)ᆳ'�/Z�[��gh��:��4�9b��K�&?�ή�L؛j�S�{��k��^v���
��[�Ʂ�_�q-��z�'�:��4��y��-�/���-q.x*�6J�ٽ�k��+ s@�lϟ��6p�RU������pݵ��}���V~R�"��k)8����Ռ�y�a���'�d
b��!"g?+��٬�U^���1�xӱ�m�S�'���ޅ0Pk���XN4jG��yN����SC;^t6�N�l�=P���='R�YKa�!����r�;�\�wNZe& }[c�����u*�߇6�3.��[�=���I����GX-ק�(ɱ�9�gZb%5�;R�I9�Ր�֯��_�����[��y����w�R��=}��B�e'�l|Q��{��?�Yx����H�01�j8"B}޴���g�5��a�h�p�M�k���PiD��,��������6�x� ��x@^oǕW&ѳy�^J:�7f���#9p�1Y�sAΥcwޭ�
�G��ᣌ'#2�Q������8�	���ƽ�r�0�o}2v�nn��p���V���Y�ȥ־ד���9V+ ^�a<2^��P�*S�
����}��m�Fj���
gW��	�XUO��C�F8� �狀â ��Z�'MV,T�v��
���9r��׻�
�Aʆ<d�"�
0N����,U�p  H&@�+����	�>6��?X� ڨ����s��vf��P��@	�X{��.@�7����*yj�:e���N�U��}l�9����h&7���`d���-�f�z����+���	�0��-n�]Xm�b��ȭ��4�@yTށQ�za���L��	����:����PA*I�i�/$/�Gn1���q���u�c���h�"��H\^�g�Q�($b2��Jv�=��w=����g2���z�0X_��T�ㄥ�0_:��d���ZJO{�@Ω}xdW>M\R56�@���M�n0��K�ܨ�{���T��ފ�a�:��/?����U3-�@�Q� :5e>���3��s}#���{Êl���:[���l�Fe���( �$��;����QȮmN뇧 �P�/fئЀ�_��7,�rpp����}U�'ƀ6Nv��qw<]ՊT�<�XD8AI�
�x�-�s3�a�p�¨�wd�|��ƬEZ�B9�Z�m:��GT��Q��KA=��V���Z�م�	d(��E<P@"�[^��Q�z=Z	����4`��g[Ps�A$�8���e<ust�>Ǝb�$ġړN�h��w�&�f�������V)BPf2�C'A����ϲ�X��qj��m¼�Q�Bl!�ɜ����/ʌX�KѱjSoJ��� �2evОHD���<5�� 8�f�����GU��0���@v��K�p�JR����iP�l�R�jj���D�.,��]̏b�����c�U�Iacf�=�]�|f���h�<�$���0��K�,��@Q'3�&=h%u��j�� �Hg*����.52�&v���6��7��d���2?U����v��,�8�iԒb�0Qɬ@��p�h�<��?�ҳ�:N8i!׃ C�;�@L�9�D��2H�'_�\�����V%A-Y�vr_��������{��{ĖK�M2��/akP7>��c��L)���~-Q헰��"S|�*�J�J�yXI�E� g�*Uh����T�k�,IA�C��}��.ds��
�
����k�/�l��ж�y�\7�~q��<��A�12�}��e�4��T�]��e��'`���+�q=J6�ܺ�C!\�+6Gu%�P��'�%��g�	"R撪��s���E�2�x}�p�Z+�Ro�y�@��[�f����*~a�z���p�_ BK�� 2 ��a����ԿpC� ���{���ȑ���AT�#S���X���T��+ie��Zۥ/_꺣3��vX�}�{���c�f����K'PE������g�����9 ��]��>>�r��r�WF��Cz���%/�D��Yf��vP�\<I�I��B�"ˎ��R�,�r)�$Z�F	|]CL�@��L1�y�a=:j�p��~�S���0@C���kI�W����W�%6C�V���PH|ʑ�p4���a� �<�9��}Ot�ޫM��;�ׇ�c� A�7g2OdV��\D��Sť�d�c3��0A���X��� p��qT;D�*�;��@L�Z(�O1����vѦ��҈���Y=.��\����n��&��� z3��6�U�r=��u]��$�]ǀ��mE5�P�2_�S���;���M�h�$@!��~y��ԗ���jjE�n@�, �+���;z9�Rm��@�1�A*F�N�������mRו&Kx6w�n~&.���fa>���;��d��4���g��G`g�Pm]M��l���En>C�Ɋ��q<=�ۤ�L��*!�?��Y[-�@��񸐓S�ѧX��)S�Vۊ@�P�x2*���J�������}�����3rAX|��$?N ӯ���
���[g`>�Y�%7Ȏr���)O4�5���M�zH�|�M}^4܁�&��퓿�`HaS�ǭ����iGڰ���\��z>�� ��pleKy�+�MT�@V��q	�ٙ���Q��I,q�V�&����^�
����{��*�Gg�T��R�iф2��llt�s���U�����K�Q�w;|��1O�E��#���J��N?�4���΋E� .�6�h$�:�����Uo	��]�+��)��DE�������_������7rlF� e����E�'����E��:�(@�Y-����m_OŲ����]$2�@0R�y���)�qO�l<�>k�ǒ\�����pF�$
� �Z9ez�"��:;�H��-@�`�R��.%T�����L|��Hݲ
;H!N�?��� T�,Z��ϭtVM���/��*ϙ\	Ȝv<ʔE� -����/؟����נι� �]�0�嘇�A+�+���^9_N��;�(L�d�Ȱ��T`��N�dF�?-�b�Mz6ЌU��m���\����^R;ګ�He����>�g����~<��j5��o�C�R�P$ e_H�BDeZ��:q�s1>��*���m��ݵ�L):Cl�PIP�B�C���F���?X��B����	A"��S�+͘�������ϭ�~Q�h).o ��Ok`�X��U ���ٵ���>���\+�'2r�'��A�@�@��)Ns�Κd&���~��E��9��],�]D�jM86��p�ح^q�s5��-!	�	��������� rB�8�9���W�7�_�o��QP�A�("_z�sj> G@\k>�FC,�0kBeаz�+��rj��+�8�d~�!���3�N����[ạ���ء��lsB�c���,u�I�֞��/4�D��K��`��?-|ʗ�<���J���#�c�0b�O�n�}v��5� ����,��B��R�'�~�qD<y�� =�Yώ�w�$V`���xR�ȹ�`��.Y=�E�lD���,��վ�ZAj%;�ɴ5�-=7F�t5�<�g��!Իw�Ϟ�����N��v�Sd�7D�N���%�6j�X�r���g,�E�������J�7h�m���R�X>�QE=ˡI��	ܙg0b���jQsw<��km-�tЦ�O�n
�V���b_�D�9Ko����̇�s�q3w�s<���'! |  *r=�Ğ�ٌO7�������J�Yq�
@K���y2')���T����{�,�t�.Nꜷ����QS�1����p���~q��i�����VY%�5�F�#C.�0������q'V�c�cnC����`5>]f�H��aj��3 q�"=2KZ���\3P����hr�{~�W:�CP��k�3�~�0����IP��K�w�$�%旯^����rf��x�t�-��1���~<7�c�B����+�4ez�`;m`h�_n�1UP��6��ů�����%��>G�M
���<Q�\c;���,#֌���x&���f�$׶��:Z��^e�0Ѷa���5n�:���
���s��/�_�;/S��8��u�k�M��ȚC&�\.҇�6'ʹZ�?X^�qU��Tx�ŕ�C���+���]c���x�^��񤃬~��e�;
��W={�����~QU��N<D]AB�Z姗MvD���[G-JG�R�Vҥ+�jz����<e*F��.�ꅽՓ]Q![�l�j�� �\=AyG}la���\7C���s6 F9s��4�ߠ�V�F��z���g��a��k�А]�U��U�ɶj�k0�@a;v7PlMN��F�Y��_F��"��U{Ec�^Q�_YWڃ�δfIr��tS֊�by�^A��	i���E�+�5P#RU��`��r��C���6c�s���������5�񸔦a	�=�S�Þ)�]�g/������4 �i5��-�?0�O����P<g���j�W"f��&����o�(�W+|��f4��A0�AMa�3��Ų�zn�p�F53������,���}3�\ �q�B*}�dӅ;2%8^zP�'��k0;։�	9�ω��|Z�׿-O�a5W�Z�����؟��w�".@������|��=<�2h7"0������FL,,d�� M���f|�b߄S���z�}�z��Qf�K hF.Z�����ִ�Fs��ׄ�r&
Ь����ђ՚� ��V�.>H`��3ld��C�".��x4b�x��t$�8%��P¶{'�fe����ܐ�R��dwQm��X��0�$���)WCS3 �TN&�;����PI1Z�<��T�'r�؋40)}�����_}��F|���l��>4N1���y%Շ;�S3#��/��U�B܌���;v���,�������Ȁ�
)�aa	�Մ*��O��:M*��~l��}=m�暓#�CP�=�]&�ۥ�9�(z�'�&�d�Bˁ�޵�����y�=mO#������5{�[����I4��=OGo -�]�4���V4�\�>�Z��~�_B�t�^�2Y�
��J9�x��{����\R����qG�����}yS,;��.k%���e�I�Huձ��<�R�tM����*�P3����P�(	<�����B3�$������9�l�(f�E�1�~�&�ɮ�c�G��]ڥd������:l�v⪱���R��P�Ӟ������k��&ᝍ>�z;.kt#~�CK�1@}��Ǻ�Vh[4x^����s*5�W��@A*�)� �a��T/���_c�Ulv�P��|-�fϊ
e�jBN��f��09ER��ڗ������qI�<�V��瞮y���Lwݡ�S���3S�-s�Z������
C[���q��&�j����z�<8�.��D;��x���n�@+{ڹ��Qo2W·[Y��Bn,|�tE��r�l�fsXI��c{�$��]����\����.V����s-�y�RwX�o�TM��t���*���*�K�'�,�st�4��	��c5>���i�aC�x�n�{Of_<�x�}J��2ۣc��M��q-s�]�������]{�'.ޓD�E���e�����S(\������G��uAT�I���d�kk�=�E�
!G��9j=%0�!�A:?�ȋz�Y;=�,q85���-��{�$`��|��xԇ�T��׊���2�r�:���hD�K7����o�e�丛C�ĩӉ#�����+����H׊��K��|ܳT�&�V�Eɛ����D+�5�9���ޓ������E��.��X��)���������`��{�2P���S�f���9���^������k�D,MlJ��`�>J,|�\ч��qП�;>9���ZV�=p�EJW���xp�ҥ �sAC.��t*�Sa�7�6fN�`T��,5�q�:xC��e�-�'���J��|Z,k\��]=ǖʶ�7厚<�0哟/�|X��h�(.���p�%���}��'gu��*V�J�9W՞�r����,�諴�?�����HG�O�G�x\���6V�By�8w������gh�1�t����BBz ���gl����&���k,�9[�D����3�*?&��#A��֌R���*���+��*��ۨaL|}�v�Fz���_R��t_�����������W�S^�������Z�տ5ъ|}S�/��9�Vg��}|�my�m���!�v�@�׾�ь�� ���1q����ᳶ|{(o���{[S���4h�9F?X��ǁ7S�}��k����w��꭮�09m��4�uК���5��M}%#�/R��_�V�����o~��0.�Ե|}.&?�B����s~�-�L��v}e���}�D���9��,]��V����'�V%���/�ެ��5�O��X�;�A<�Z�|�vF4h=�N\|��I:����Ĥ�N�b���IF W( ��a�&�g�oS? ?��Q_g̸>U���#׮\,Ȓ��)���D�k���T������JN(�c%����nA������:p^�u���O�Ɵ8I���m�ܡⰜ0���g�b��O��lz���5;~��R���9�.���9�[i�ȖY�F9�b}�H���{�i���L���CW�v����z$K�%����>e!$ĵ��$6�&�(����Q	�\J��k�q�w����F��y�����d_]:�ɯ��7$�Pˇ���N��Q�		kz:����%)��+��[�HJr�}Ӈ������Ө`�g�O�6��d`�L��<�j�	
�y�5���/��䉐=�d�z��Ś�g{t�;���(��׳?����/�_���_�?�N�      )      x����j�@��GO�Hٝ��N 
%N�r�q�#,�O�~�N흍��Z�B��7�9sfW�}���5�����v���o�BZ�Έ��2�%㪌k���8
�D�ʔ�#H�	��z��m:��L�"�!��"LC��;�h$�Ɯ�XIQl�y�e��w��e�J��8{X�(�Yvؖ�n���!xβ�b�5X���k�nv���z��e�^q�UAF�V��)1,W�Q�	�9�K�
ʞ��źn60��x:z2�ڡNb�iH>���"N�-O���`�/�?�U��O��Ӿ���Q�v��m�&�*��m���K�՗j���L`Z�]�z����{<�ܤ�'�� @�u�rg�;�lh���V� +
�3l[�����3m���p1Jg�_���{;�	�Y@���b@�
>m�ng4�?�yw�*�]c=[���M&�@���H�g?ZH�-���@�;�0�vouzMn��z��B�,���,r�Q��mF� �g�ʈ� ˟��oUU�BTj�      %   b  x�U��j�0����G3��aO[�����̒LR78�!oߑ���	��ͧ�3v�ߓ��cG��6_l�^4b�T�C�X8A����L6ڂ	˂sNH�a~��k2���KrzƻϓM64� ��ƽ�4.�����ǆIS��R��{���l8t/9ւ�����
pSeU�y��v��TT]\�ĵN����>\��M暉Z"D����}�Ɔ��k��rr9*x���7�/� VX�a� ���ě��OS?}��VDW�^6}4�ة?���ֈ�Ϫ��7C�n�v�;�����";���_O~t���/�U�_c���1��|�<��ߟ��W��R�ӠD"�ZÿB�Ot�)      '   �  x�]W�r9<�_�c+���}9ʻ,˭�2���dr$�dQQU�B�����L8l����LHv~�2�f�=��m��_.�W�N�?��G\H����i��B���6����1O�.�q�MН�>2g�\hv�;m׉Iۼ+�N�!�=�>��E�iO�0��>�r�χ4����D��JϽ���؅e�ÔS�/��~w���v��~Vx���L[�]�~2NV9��S���O���}�	�E'��Dp�0�.��d;&~z�=}��w]�u'm脉�Vػ�\�K���}+���p"J&5���ð�b��S�׏)��1��1�'�����Ԧ���ͣ���p뼥��BJv�͛��Oy�� �Ɲ��
� �T�u��6l�����s��}��2�,�������Q��#7����a_S���q�42t�V���NZ�=i�q���C�n#u�K�]��l�ؗ%����4桮���N�Cp�V�]�n�tp� �y�o�@�O~��:Y�g�+pW|�C��~6F���@�B#��zK��}��˓�\	Լ������*����1cϫ��i� %��	�0�1Jv���2���yJ��iW�ت�T�A����˪�i�;�e+A�]ϖ���-mY82Wbl�7���)�P�Z'Blʏ�ZET�wڋ�e�izڦy�A9�i|�S��.�C@�C�3M���/R���ٗ�%�\1/�͘��}+e��h[W��
艉�͡o����*���X�� �x�1.��8�I'A-TPz��2�q2>W�Y���hc�BK�{��t)G�`M|�|A������2����I����)u;Z��������_@@V��j�7����N"m�6���w %�8������6����.<Y��Eu�3�_a�0�_΂��O�B+2��ՙ����1~y:<��Vɚ��GiL%���j)D�u��6]�t{�w]������ �2V��n�Б�+��<�c�2��y4R��XD�d�3�:�ϐ^(GWzB� ����@SO�2��J��ox����;/�l�(�h'��{=Kj�^E�y��T�*����燡= R�����}E~u�vC�煑�8R-��X�>M����p�����^C��%d����,D��l��*��=��i��p��wi|��ڠ^�|��M`WKN.����J��\�s���.��]�>7������nh�g���Ҭ�
���J�P�`�f�b?�[��1s
��3��lUc͏Öu(<8���4,�(~���4��w VvR�&�ְi��`Z.�o����j��#���ZQk��H��#��	�a'�]��]���=����)�̗��������5����7G���-F	���6H=�����4�d�P�3�ȴ��Q��붳��H�q�~���I�<���Y6&��w�∨�n=�Hw$���~��C�j	}/���<�,!��}��{����dm[�<�SWk���a=o��B���S�fUΰ�����~@�fbɢUZs- u��x�i}SB!a2�5G	W�H�. ��)� ���<�
+����r��++��GhD�5ނ�W���Sڵ���!����s��A��C�im��:\G�Y{>"I���[\D@��kL-�J���!�.�Ҁ�	�W}�$�
S R�0�"F^���zq;���wQT��4S������y"�1x>��4 �~�E��敆�($)�+{�>���ג眦I��.us�)ϖ��� ���,M�
;Z��=U��@\(@�,%�h������W��|3��� �e� �E������J>r���-���}ڀ�P�G�q^��B�!�'ƫ�%��m�IY@;[*'� �dV�H^�0w�!��R CF�0��yI�����+14!H�kM	��J-�Q�v��w�C�������nʎƺ��sS���ɯV�a�V�^@5Ri�I`'ØV�]q<����A�b��ݪ<�(�����ř�����]�I�Q�g��0��G%�ø��cx�!���@��as�H+��ږ��b�a^'���~�����\��tMS����}�˵��B���
6\� �O���^^Ͻ�j�Ӂ���E��7	�*�fd�b ����x>cZ�:.�)�^�01�gg�:�*��,���YJ1�R`@�E'[�l�
00*�K T�|��c��=*�sp1�2]mfyp��e-oi� ;MY�������Sy)     