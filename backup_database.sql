PGDMP     (    8        	        {            finalproject_pacmann    15.2    15.2 6    7           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            8           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            9           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            :           1262    17184    finalproject_pacmann    DATABASE     �   CREATE DATABASE finalproject_pacmann WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
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
       public          postgres    false            �            1255    25793    validate_buyer_role()    FUNCTION     A  CREATE FUNCTION public.validate_buyer_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE user_id = NEW.user_id AND role = 'Buyer'
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'User must have role "Buyer"';
    END IF;
END;
$$;
 ,   DROP FUNCTION public.validate_buyer_role();
       public          postgres    false            �            1255    25795    validate_negotiable_ad()    FUNCTION     B  CREATE FUNCTION public.validate_negotiable_ad() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM ads
        WHERE ad_id = NEW.ad_id AND negotiable = true
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Car price must be negotiable';
    END IF;
END;
$$;
 /   DROP FUNCTION public.validate_negotiable_ad();
       public          postgres    false            �            1255    25790    validate_seller_role()    FUNCTION     D  CREATE FUNCTION public.validate_seller_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE user_id = NEW.user_id AND role = 'Seller'
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'User must have role "Seller"';
    END IF;
END;
$$;
 -   DROP FUNCTION public.validate_seller_role();
       public          postgres    false            �            1259    25748    ads    TABLE     (  CREATE TABLE public.ads (
    ad_id integer NOT NULL,
    user_id integer NOT NULL,
    car_id integer NOT NULL,
    title character varying(50) NOT NULL,
    description text NOT NULL,
    color character varying(15) NOT NULL,
    transmission character varying(15) NOT NULL,
    mileage integer NOT NULL,
    negotiable boolean NOT NULL,
    post_date timestamp(0) without time zone NOT NULL,
    CONSTRAINT ads_transmission_check CHECK (((transmission)::text = ANY ((ARRAY['Automatic'::character varying, 'Manual'::character varying])::text[])))
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    25747    ads_ad_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ads_ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ads_ad_id_seq;
       public          postgres    false    221            ;           0    0    ads_ad_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ads_ad_id_seq OWNED BY public.ads.ad_id;
          public          postgres    false    220            �            1259    25768    bids    TABLE       CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    ad_id integer NOT NULL,
    bid_price integer NOT NULL,
    bid_date timestamp(0) without time zone NOT NULL,
    CONSTRAINT bids_bid_price_check CHECK ((bid_price > 0))
);
    DROP TABLE public.bids;
       public         heap    postgres    false            �            1259    25767    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public          postgres    false    223            <           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
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
       public          postgres    false    217            =           0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
          public          postgres    false    216            �            1259    17470    cities    TABLE     �   CREATE TABLE public.cities (
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
       public          postgres    false    215            >           0    0    cities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;
          public          postgres    false    214            �            1259    25733    users    TABLE     k  CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(20) NOT NULL,
    city_id integer NOT NULL,
    role character varying(6) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('Seller'::character varying)::text, ('Buyer'::character varying)::text])))
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    25732    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    219            ?           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    218                       2604    25751 	   ads ad_id    DEFAULT     f   ALTER TABLE ONLY public.ads ALTER COLUMN ad_id SET DEFAULT nextval('public.ads_ad_id_seq'::regclass);
 8   ALTER TABLE public.ads ALTER COLUMN ad_id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    25771    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    223    222    223            }           2604    17498    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    217    216    217            ~           2604    25736    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    218    219    219            2          0    25748    ads 
   TABLE DATA           ~   COPY public.ads (ad_id, user_id, car_id, title, description, color, transmission, mileage, negotiable, post_date) FROM stdin;
    public          postgres    false    221   �C       4          0    25768    bids 
   TABLE DATA           K   COPY public.bids (bid_id, user_id, ad_id, bid_price, bid_date) FROM stdin;
    public          postgres    false    223   H\       .          0    17495    cars 
   TABLE DATA           L   COPY public.cars (car_id, brand, model, body_type, year, price) FROM stdin;
    public          postgres    false    217   ,w       ,          0    17470    cities 
   TABLE DATA           I   COPY public.cities (city_id, city_name, latitude, longitude) FROM stdin;
    public          postgres    false    215   <y       0          0    25733    users 
   TABLE DATA           K   COPY public.users (user_id, name, phone_number, city_id, role) FROM stdin;
    public          postgres    false    219   �z       @           0    0    ads_ad_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ads_ad_id_seq', 200, true);
          public          postgres    false    220            A           0    0    bids_bid_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.bids_bid_id_seq', 401, true);
          public          postgres    false    222            B           0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 1, false);
          public          postgres    false    216            C           0    0    cities_city_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);
          public          postgres    false    214            D           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 100, true);
          public          postgres    false    218            �           2606    25756    ads ads_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ad_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    221            �           2606    25774    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public            postgres    false    223            �           2606    17500    cars cars_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 8   ALTER TABLE ONLY public.cars DROP CONSTRAINT cars_pkey;
       public            postgres    false    217            �           2606    17479    cities cities_longitude_key 
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
       public            postgres    false    215            �           2606    17546    cars price_not_zero    CHECK CONSTRAINT     Y   ALTER TABLE public.cars
    ADD CONSTRAINT price_not_zero CHECK ((price > 0)) NOT VALID;
 8   ALTER TABLE public.cars DROP CONSTRAINT price_not_zero;
       public          postgres    false    217    217            �           2606    25786    users users_phone_number_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);
 F   ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_number_key;
       public            postgres    false    219            �           2606    25739    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    219            �           2620    25791    ads ads_seller_role_trigger    TRIGGER     �   CREATE TRIGGER ads_seller_role_trigger BEFORE INSERT OR UPDATE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.validate_seller_role();
 4   DROP TRIGGER ads_seller_role_trigger ON public.ads;
       public          postgres    false    221    225            �           2620    25794    bids bids_buyer_role_trigger    TRIGGER     �   CREATE TRIGGER bids_buyer_role_trigger BEFORE INSERT OR UPDATE ON public.bids FOR EACH ROW EXECUTE FUNCTION public.validate_buyer_role();
 5   DROP TRIGGER bids_buyer_role_trigger ON public.bids;
       public          postgres    false    223    226            �           2620    25796    bids bids_negotiable_ad_trigger    TRIGGER     �   CREATE TRIGGER bids_negotiable_ad_trigger BEFORE INSERT OR UPDATE ON public.bids FOR EACH ROW EXECUTE FUNCTION public.validate_negotiable_ad();
 8   DROP TRIGGER bids_negotiable_ad_trigger ON public.bids;
       public          postgres    false    223    227            �           2606    25762    ads ads_car_id_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(car_id);
 =   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_car_id_fkey;
       public          postgres    false    217    221    3212            �           2606    25757    ads ads_user_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_user_id_fkey;
       public          postgres    false    219    3216    221            �           2606    25780    bids bids_ad_id_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_ad_id_fkey FOREIGN KEY (ad_id) REFERENCES public.ads(ad_id);
 >   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_ad_id_fkey;
       public          postgres    false    221    223    3218            �           2606    25775    bids bids_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_user_id_fkey;
       public          postgres    false    223    3216    219            �           2606    25742    users users_city_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_city_id_fkey;
       public          postgres    false    3210    219    215            2      x��]ێ$Gn}�����6�~�7�ڀ����%�ڀ_J�x��hf1�Y@���av�03�.	�&5Ŏ���OΞ������矮�~�|���������Ͽ��z���z9����ﮟ��~��|��旿}��rN��z���ooο|�������������׏o�l5�?�?<�z=��������]O����_�X����ܓ�O6�M�Xqvq�O�C�|���o>]�����z�����7������oov�Ő�V��>������wm��{����iy��ʉŝ�wU��'�&_,i���dԬ5�}~��7wjz�흢��)��n��b��;;{1�b�N�����x���z���z����K��08E����r�_N���N��'���]��ĸ�K�'�f�����w����:[�@K���%KJ������Գ	�H���t�����?���t|�;�o�}���֓A�̵{�BG�ݷ�svt���rɧT&��z�Ι�F��x���fa�GYa3P2_\X�9��<ʣ�я2�2:ʔf���Z�'G�M��\\]*,;mN�t�__?�����~�J���vlе<�IȒ�پ���Ś�O��j��������|���vc���������5w}�Sl������	�'o�=F�g�J�|x�]�W���<Ezl����)����t�	N�'X6Ɲ|^}1��x��|��~.e�9B�ʽ!K�kF>'C3�.��O�l�����l��m#Lo���l�&"��R�����<�� ����rz�gs�8=�r����R/�,Q��j��͛�׽�P`ugS����$����K$W�薽_�p}~���G5;�֓����6�\MY*I���q���Ť�'#ɜ�هR��k��1�Q��Y�=L�'�$k�'�t�t�/����.1e;�%r�d�Gɲ�c4�l)�p��&_�Ņ����S�9v,&h�p=��9��n�sOh͓+x�!�-�#�8�������o�^�8;x��v��S\��a2B�3�g�=�,T��:��~������A[G%B;�e��=B��=&�G��b�@�&����S�}�E�~>�r�,FT��A2F��bO�%e�9��2��[1UjA��e�OA���REH��Med�Y�Twƽ�J>��e^N���6�R��ɘO�,[/�(���io�cA�5"XW���-���L:��������#vH6�چ|�(BH��M^�^��Έ��R7���Q����Lp��,�{��u���&*A� @�U����!G�*e(	������S{ վ�	�\sB�fq(x�T��x2���(Uo؎�\�3�#�׃7���{�c9w8A�R,�k\O��r�����W��9F[j�?�m��h��D��ԂR��z!��a7SҥG�u7;di,N�).SL���x�l�$���eA.��˂l�䷘)�n�8�X.�->�U�(�Ϫ�T�@�&CE�����e��߱�$�6���+���q�s���J2�r�l��I��P �f�Q}O��Z�z���I�c��)�J�j:��H�����,K �ƣ��o���ʦ�a�5]�@�]G�E"��,��]8C>��c#�uv�]3H.n�r�CE�^�a��7Wk���-����Ziki=r?�!M�$2X�����Q�:�cW�Ԁ�w�I�k�������9�g�{�G{��$��{��ZmF@�����kdQRA�j��l$���ӯo ��)2�"\�n�eގ�氭��W�8?�X�Hg�T'�"��B��<�DSP}}�ojOp������2�`��z�a!�)6ϔ������`�ѐ��5,l�mKKG�a!asō���H��̷��}4ai�ɸE�](����G���K'���7䈰�-���
�DU������3]g��n@�]5��Π?����	� �nAШ���tn.ֱ�+W`y�㴐�p���+��X��f٭X�K FUk�
�i\�S�#�a�t��J�q���=j'<����*��
�q��QV�{�4�x*+�3RՇ�e�[��0�D�}��l0���x��C*�=�G�/u�BWQ�\��ʭ�Ufaw�)���r� �Ąf`xAɚ�ݰj[��(S����i�d���%f��}�D��YG��v"{Ԓ��~B� )�W���+Azk\?�u�U����=�!9R?è�E�5V��c�����QH<ց0��]�hQ�'>¡��M��m֩� RdaQ�x��*Y�G�V�y ���d�Q�(��I����E0 �&t�-��l����m~K6�տ�	oe����Ёk��c\� X��,Uf_P��p��a��z�fΡZ?
�յ��b�,k��A� �N.g�=�vMy����&U�fY��A��1hsx�Pe����Y�	ZL�P3�0Y�.�\�y���O@cJbaS���z��<���Q!�+�j������p��)�<�u��K��9`,]K:��W<J'4{�·.}��Il�˹�_�z�	dd+T��q��fd����%֪�KBv?>p���Q��J�Ou�^M�K.�ng(*݌ň��ؗPb�����ZX�zz��Vǖ���mP6΋�0G��Ci@!ǅ�3�[���G���U�#� ���Űd�)�SY�m�����j���#�r������8ы�����c�q��z:ZD���&m(�����$-�&P�2�%gN�d25�	�ta<�Hv0j�"����q� �d��L*C�|+�8��X�,V����\q�3��;����e�[�bd�0WPN��f�R�9������+cA�C
a���b)��TS���z���䖚1;�R�G�b�c8oƾ�BІ~6�����b����?Չl�K�d���'X% M�1�K[�R�YJ`��DP�*��{u�n��* E�!(� a��h��в��i����i�9� Ӷu)�H�k����R�vm@'��4D�b�sg?���D�ޠ�n��4�9!)r<�9�����}��_�	nP���A5��0�ps���4��y�k	N���!]06���dI
�C+�t$k�h�<�`-Ս��-����
a�T��1�;t�բԚ�6�T��c�1��G@�H"�X#4R%F5�GT=Mok��X�Jn��e�*��������E���<y��Tw�������E�iD�VA
�[�����
;��=f<
���ȕ$�6)���n9	� 8L� �R��'�z5�M)�~�����.��?�
����;f8��{��#3	�'�0Q5��_��&�)�Øبl�pJ��Ҧ�)��y��HvSA���Q�zՍ6��]8��"8��@.�o�YN��^��G-�yD� l7�e��gIS{��v�Vl��j,M�p$��1��q���`�:�bG���rp��&ۆ	�v�ʂ	��6q�Ř3a�����ݐ�E��h��BGz��̐��l�g����]����nnb.��y�T<W�H�tۇM����)r@82!ܬc���C]�hB�1i�.����c��i�<P��Kμ�`��&���e�@�t�Rd�m�&)�p�����y�f\vyܮ�H�0N1���+CuK�&v��::�,�%I�j�IyP�0h~���h�M_&۰<��
�"��{���,ĞYw�}�!|��`Z83��)���`��#㻎G��j!�I�w�*G�; �&}yBp���v��>��m{t@�:$�Ԍ3ԅ�wt)�>=�y���r�CQh�Y U� �SQ�:3dK�OE�8i��jG����x~BN��=��,l�u�l�Ұ������O��ԧ=�sH~ M$/�
{1�z A��}E���1��y� �Xf�{le��<�W��Χ��YY� �q�;\��;����A:I���.���H$�>O]�UI��q<��#>�b�Zhv(�X��������)��$��լ&����:�&��;���k����c���pn���dR��0,/ ��n�z�w�u��}�r�̢�@��(�'��n�#�sk��a?Dm]G�( 8  n�<΀�NX��[�m',�V<z��C΂��&�=����|8��X�p��+�1of���\LG�妏5��`d�	<�Nz�Y�c���ta �Z�hȂd�.\.�x��\ی�S�f�J�!��\�4��mxn��6���R�|g��Jw8�UmI�"�ƽ,4s�,�Q����ӟ5���X�������Q�.�ەܓKHc�]��sM��nF	�dm��\E�֒��sn\_�Zp} ��mK�9���J�Gz��f�]�Q�8�w��� ����.��fg��� K�̓h����˓��CU�&A>S�;D��ݐB��qJ�.��;��[*�!�p�chQ;��t��L�,E��ݺ�Ġwc)i#/99]�s/B��О.ݱ/¶��)Z���B���p	�>ːݫ��(�r���&>_u`���G�ëߠ�m�_V��x2��
:N���џ+�5ͪ��A��~��J+���X�I����j���S�i����hR�m�X��4V4߽��^�]���-]�� ��%'���	���4�Кj*~�$6U8;�����MF��^�w�u�ԘP�.ŁɈeT
�{�9&?����3ъ�Q�}f	V��g	D%C(�C�����F/�T�J�RdS�32���N���������t������A� �8��Ǘh�G<S�Ώ1�����$�"�!É�M`hڶ�X���[��f��ȫ�g��ªO����+>��y:���1v2Ұ��B@��H7"Ҍ�����R���[��#i ��*�F��R�S1������o�$�ڜe�5P��a�b�&��lUg����Y�v�0���a>��Y��%�T�A=�Dt�˒c���AfV�#��Qa���K-:@��li���D<0禡�m�Is"� ��!+STLv#y�W�ʨ�Ȇ;�b��x�-OQq�ޏ���{�;���d�x���2H��m����2�M�f9����N�N;%�(�gxHzAS�h]|��t,h L��{��gڛ�Le*r�N��.�)��7���k*y�"���:�)���j7�Ԁ
�~I�ϼ�[i,�hX1�V��x7�e�Ǡ�} M�8y��$��]�-Dz@�Zh�F���p�&g��+������)o,�����h;G	1�Z��Ú_$^J3��7�]w[`k��8�肬-�� vI�
|�����a�p�� H�	�|}��1�y�h;�
Rec�	ek;������f��d?[�|�\��Ԑ�������Y9��n7P���)�B�A�Mm-�b�Us���������ʼm�y�9��z�Bֆ,d�-5�B?��TF9�:Hnb}d��5��G|V��r�0�8�]�DN��-Xǽ�y���6'�5T^����:RAUR7A.9���(�oi��S�a�aμ�ijpW�ͮ;����R��.��]=a�qәƫֈõM.���� ��/8&��
>��?@Cw3��~�F�Q�&�3o�d5|��ހ�z36��ykG�a�>dI7�B^�4đ屔̅��mG��FE��(v��S�2�+�)���9 S��f���,H���[t���B��N>��'ٹ&Y2���X�]����Ԏ�;L��PP��C��S4D�a�Q4l��XUӊ����Tç����>��R2ѕF��^ݰp�r��Ҷ�
P5�1,R2�$�ĸV�5�k�㴊+�Z_&I�M�w9��WbG�k�<h��Ta)[�$
Ϡ�4��W]ɞC���m�=�d���J�.W���e+w�fί�vuu����5�,n��a,��'hIU����)߽�ֲ��3g1��6�Z'z����H�k.#0�m�_i�/�Rs->���"�CI�b�I�9T�$G���ó��+>?3Y���>��溆*�������{���X��t��5�X�+Z9�n:b�~��Yi��R��ͯ��k,���ܗ]Y����ςX�.�P	H)Ğ5w�Wl	H�#s3��Gp3ׂ:���a�Ma%�rǏ�c�7>|���a�ݬ'�����c:�!4�T��1MQ��y�O���q����&�b��a1�QbY���?��,��L���      4      x�][�,��=�&�\"�ύ���a Դ��ߝ�|��D� ȱ��򱘟V��Z>^��������m<����'V��Q��U���������6>�>��Gx�U�r����~�>�K��ZZ�>�*����c��������l��f��;�?���u������B��g)��~J���[�3>�~l����u���Nn�`��7ڃo��6�F�������s��~�?����쳢԰����O�ی�
W-�=V���������c����b����5ާ����7{�?kj�M��V�U��۬�m�맶��5��L�i�2������ψ��a>���W֏���<�+��O�T����6QyS���?�?m}z�ݬ�z.G⿭� \�c����΅����X�B���½������;��x+�o~w�D�k��Lpv��:� ����죍1��F������M�!������\}`]y���\��g�����t���Z+-j�o�!>�1^?8}\�5�}��'��±�x�[�s��b�72m*���m|��2g_�die�5G:?>�Z��5���ɝb5?m2J���dC�?ґ0�}_��xj\Y�w��.l����E� �p���O��_l	F���\�{���[��!��6�鵬L�H�����8`<.��!\D�ڹ�2<~�Z��:��B��V��-��b�� э-6��9�<��Ke^�Z����D�`���.��;s�o�N
��<��Qr"�fűD*�+X���`CX��C�I����hGjN>��*�����h!&U�l�n�5��;@��$���t��s����:8� �xk0O��� ؐ'���8���un�7�>���4ક�6�Oo�J��]$3 ���1���ݩO����$`��|���~�I��
_����A�bt��\�6����pc �ϧ5m7�F��Y�
����O)
HA)Z2�'���r�s�BAB9��h���9���^�	�0�dx�p��S��N���1x3v�Y�g�R����e.��j�A����!���o�zO����&���D�m]��۪���6�mp-J�R޸d"��!���:8����g�ǩ9��t�z�?n�~��U<�
,��:�5�T*��O�"��Y��ʩE�#<Έ5OW�R�Yh?�gj�`(�N���pAP)��Z�~�#��"���g��ZmV�#	�0Kjp����z�/p1L�߅C"cX,Oګ,V�q���yi+#3�A�7���b$�is�*�$�ş��f��� �ʲ����u�<�Sj�m�z=�A�z�k��`���yr6~���e���w�1�����4���4D̙�[��'�Y�	r1��g�h������Dյv�"���Ug[�I�L�Ŕ��9D�W!w����_6�� ��u�\�W�
�J�;JI������ѽ�9!�)@�:.j�	9�c�d}P{V�z��UUE�?Hi�Nj !26��V&�|V-|���&nQu�6��h�� lη��j�~ ]�� �sċ�$���h"�	���,���2=�%O��*J�* ������@�fB#fw�ۗ���P�C^�9�C}� r��$�2�{-<���v�D3�	%�-�*��.�%��X�"ȉ�\����\5�U�70�`�1��bq'N���˳�~SJX�,��fØ��\(�@{^j��\?�$�"��,�Â�9O��bYu�k��
�X��me���ʏX8d�ㄧ��=Ydp`ө���*<i�<`��8�4���#�Mt�*��b����C����z^p65��z�#+�o���"����x9L�)��6ڇ�#U��i���4��B4��#4�N��T��>p��Kk@�D�v@`0��� �sA�C��z�)�!����e8����IC҆ �{�]�AF�p�ǡ��L�a�c�K}ݲ�	>H�B���N�Gs|���K�B��� e1��eVO�ߍ�W��T +�9�-J'��%E/:�^11u��2Ao�*�;�p�~�)\��\@e�F��PEs��}vHT� @�{�F��0%�La�[�y�Mħ�0��D�́��r��N���u�7�Bj�8�!Έ�b�h�y�`\���AJ��$>�p1���cHW.b�>�a����u��x#����$��kPm]2JJ�%��` �(�&�
�⎓w���{������A�� ��,a
�c2�[{�K���PY*mD��
L�u�!��� ��J��  "9�\��c	2. Z �g��u����%{�����F=�S��"©a�bap!�c�<(��c��~i�xtZ��(7U7"�ܢhգߦ�*CJiZp� ��ĻP��EPa�D7B��+�����d�Iဣ�Y������E+&+�W{���k ���U�ߋ`)aW $w!��{���͸EN��}#;�jMn]'D��z(�e�a�\('<0W��`M7�\I*M]LP�y���[y�eU�
����ȵM�:(��S%���q�}êsbdBz����ć��7Y�x}��@�S�p�V7ښK	pÓj��y�����óV�v.��q`��-���z�D {i�"�Q��ąxL�{1�F_��ئ���ÊFk�L�T��7�Y��M`'-.���ޅ¶�Db}7�Gf�u"�e��|^��d����ǵ�3X�Zs'�b���_'��B�%�m	YJ���8��͔J��Bn��ژql��.�;X;�(ʨ�B���,t��$	Y��� /J�%�/�Y
�	H�z�1}Z�����������g�S
�U����4$�rJE�J�D2ߏ�J��zq�Pɞ������z��,��и�*L\�8�/�{��F���ہ���(�G_ʳ���a�s�&=Q�����JuS��Ӳ�KK�`��P4rK�;�[�|�Y���4 �m2l������W���R��sC���;A���ObI����1�P��\�[���O;�J�6��M¦uEP@�K�Ѽ�7�-�!�-�E�=^
fޮ#����f�@��"c�-]�v�oz�B��K+�{�^|�զ|yq�d���2-���8 �M~�>���Z$X"[E��	2�x��O
Gf�O��!R�����iX�����^��%�]D���wȟP]��Ĩ����|�|lJen��^���sv~�xMKl����LoSM���\O5WJ��t��M�OIō,���He�����n����*vɴ[��*��8
-����T�Ķczɍ&���A�_|��IB#�ˤ�XP|��>�n}�*�%����~�����G�'qX�V͑�(��C�f�W'�"�V�WD
T�������a�%��&d�@�������iGV�R�ǆ@ uظZf�:�e����c-��/�K����Љ=&�&�}�%�1���U\3�T��..U>\��d���C�@q^�D��E�u��⅀A�Ia�'5yi)�s�i��� �;��}�+�i)W/�PU�d�F��A<`IBe�rJHa�Ӌe��&�J����G�<�.Џ<���`���PJ�?��{ r�"X���.���/z#Z�N�Q����v�բu��L8����"��c;�ca|��\�4��4�\��YM��Wp���O�2Z=��u��}<6_�RD���~���|rFB,jt��ȹ��X�e��x�h�@ῗQ��Y�: A�y�%<�����gj@���;?j�c˗�Չ]�2�#c�c�`k�D�KaP�:�Eic�[*�'-"�����<�a�B���R<tJ���6�fA�n8j��#Y���'䁅̗�i�=���%����"'�N�kgS<!A�[.��JJ��Dȣ�d�_�@�Y�� ��n���ｽ]�*�ң\�V����Lu�M\��"o����7�]~��&Ž�5e�J��=��b��--��
�*�k��u��s£�[����ƭ41Ue �
  �Pch�PP��(�4��r�Uqxʍ-��ucw���������������NI�.߆'��|�29lӏO�f�Y�����@zK~�h������t	�k�ms8�de��x��ۤ��.�7>�MZ�I��"���롂c��%s�����;�4��\
��.<D�@T�rO�f��Arִ�HR2����k��&P�,|m�Ǹ�2��ĐL��A�2D��L�n4������߲��:�Ї��.���60�5�:7�諸Ne�Չ�"����l�6y�.��D�����~C CT1u�pg������lN��(�6���p��� �J��(F4*5�}��)�����.8��2�q�>jf�t���8����9�2��d`�)�(I��P��MM��HY�`U�m�;� ����]9Tg�r�4��I�(��f��i�0���r�b��P4�p�2�g��c4��/�y�ca��P�������~�]�s��1�=q�d�]P�'݋�Fv��@����aQ��z��S�����X��?�q��)�Ca��ޯ�\W�Tw
�U�A0yR�������.�5id�z�<�$�i���@�.J�h��OQJ"Qq�R�t �J��"[3
G|ym��\�#l�����*��]~�̶�u�C|K@�fĝ�C�cZ��C-(�0X����SH�2!�n?��#������o*T)7V�>�]I�h9ԫ��*�� 6ɛN��~;Uds�:_)^�ޙ��h_1}��ח� �����9�2ʙF!�T�A|`�ߤ�����zө�srP'<¾vZ�ץPCV�>�m^ Q��l�,���?�i�} �'Xű��.	/x;
�������Z4$�>S��L�5{�vL�˔��o�%�0�~^�.#���p�B^����ȬKKu$g\�2��/��<�>���M��r��c�4�>����U������uy
Ȥ���k6wq������%���fLA�8s�V]��ܙ���Nw�|��>^=
vɛF1fpਜ{�l��[i��kAr�1�3LC��-��GC��(�.i*��'JN�(�&��0�M��\'�ww
���e�}_�\����Z��OH����P=�<*j�`�^pvLT0Jr��7N�~�JI3�Qh���I+r^S,$�E�N��8+�RNF�1��}VM��Ї`2�g|/�6�
��X_U�kS�웪���q���͝o^�T�#��qqs9�.���S ɇRv���ƶx�(�#Gk�ɘ�m�>�F )��P�$o�s�FfZpV��{]2��Ѩxia"*I v�'s�sh��4҆�/��~�ݾ�d��t)��t�`r2�,1c������'�DdHz���}�M(^5�"�]7�1�)�7J���.�8gU]�%G(�]P;�>GкDN��=�{�D�+q<���/F�^��=pS�sĠ��F�?3��J�|�<-�P�1=��c��\�/�K�*�p�� �����o�^G�<���m�E�6�h�6w�q�3�(��z9d,1�
�Y��R�^��)���a�i��D_&CE�"^/xJ��E�4&@ �,�x5�WŘs�q:'2"10��;%�k�������t��h���Q7���9ڀ�mF��(ה��/�:��k:2^@��
�4������)���y�%6+z<㞴�����VU,��"�� aF�R蚑A������7A�[9.m�����Ê��<�o+���D���'(b8�~|�����y��^�F\+tn��P�3�H�m�8_�nG��JI�be
d��~���S��9x�Q��Z\.c��CU�樔div�-U�kJ� 1Q�"t ���������I�u}��1�sׯ�x0H%�P�,+;��	���x%}�=�ķu�<�`ۿ+�P��*B�0��ъ,���z������@�FJ���4�r�QC���ZB3
���L��ji��9��ߦ1����6x�%{��l�����ߗ�C�7��bU��d�޵U�;Ƽ7�n�ʰ�|��F��|'xs%oB���H�Βx(�� d�vu�7�6Zԫ��I7�
xq�$�� �*n�R�w$�A����B6]�q`�9R{~�~��,���J&���^�`���]Z~�Rӈ��"��/��|7�{U-7��!��-��{Xۃ"1�2���^���+DT[Iw4�=yo����>�-R��,8x����	��\�w
��}W���XZ~Њ��d{��:��0����`���^�`i���N�:�c�*�I��8��(�Iڄ��R]sKk ���N�<���J]���^.����T�E8
&�u�A��cV�5���6��;X��Y�x!�`�^�^3s���I*s��귦,\~�c�%$> o�)N�iDq�v4��V��k�*KS��]��-��33�W�/Ykt�8��|�E8��Zf���u�3ӈ@Z�K��+�Ye�m8�)�R��������]��s�. �s�)ٕ�45���3b�P��n��(ΰݵ��!�r����hv�B5r���苭z5�m�3�#ř0���~��
Rv�cw�� ��:���_�Q�1�4�	�)�㦦�aY�,��?�=��kτ�-b]ç�7�x�{nM�7�NJ�� ��!eqS�Z_7�D�3JL/�F09X�$�8��E+��/>I�J��Q��i����������Χ���~������R�����?���s �      .      x����j�@��GO�Hٝ��N 
%N�r�q�#,�O�~�N흍��Z�B��7�9sfW�}���5�����v���o�BZ�Έ��2�%㪌k���8
�D�ʔ�#H�	��z��m:��L�"�!��"LC��;�h$�Ɯ�XIQl�y�e��w��e�J��8{X�(�Yvؖ�n���!xβ�b�5X���k�nv���z��e�^q�UAF�V��)1,W�Q�	�9�K�
ʞ��źn60��x:z2�ڡNb�iH>���"N�-O���`�/�?�U��O��Ӿ���Q�v��m�&�*��m���K�՗j���L`Z�]�z����{<�ܤ�'�� @�u�rg�;�lh���V� +
�3l[�����3m���p1Jg�_���{;�	�Y@���b@�
>m�ng4�?�yw�*�]c=[���M&�@���H�g?ZH�-���@�;�0�vouzMn��z��B�,���,r�Q��mF� �g�ʈ� ˟��oUU�BTj�      ,   b  x�U��j�0����G3��aO[�����̒LR78�!oߑ���	��ͧ�3v�ߓ��cG��6_l�^4b�T�C�X8A����L6ڂ	˂sNH�a~��k2���KrzƻϓM64� ��ƽ�4.�����ǆIS��R��{���l8t/9ւ�����
pSeU�y��v��TT]\�ĵN����>\��M暉Z"D����}�Ɔ��k��rr9*x���7�/� VX�a� ���ě��OS?}��VDW�^6}4�ة?���ֈ�Ϫ��7C�n�v�;�����";���_O~t���/�U�_c���1��|�<��ߟ��W��R�ӠD"�ZÿB�Ot�)      0   J	  x�mX�r�H<����V̀Q�r�[�$[r8,َ�KI��A��P��+ ����C�-�2�Q��T�f�oW��S�ؿ������R"h����]��j�(��j��X�R��M��1���-�t��u���`�c^{��Vu���]�:�=�Ҧ���=��Mavаq�Wy��ӑ�N�q}�ӂ9��},�-���M�����u�W�*r�edV�|ױ���k�|��7�6#������q�u���L����};<gz���K�B[圩\��I}*P`�-��!-)M4����}�mF�O���EU�85���{�Z�ӥv����vg<8�%�OR�yI���>s�ҡ�Ň��JkR���b�n����/���<���v�3�@h��שׁl0��K�?u����y4l�.u�}�<z�fW�h���7{����~Au�[J�Ѯ��pѲ?��n��G�9vAFTАQ�)L�*�a�w/��7�	 F�脟�ٳ���2��֩�5�F���.H3�z(Sp����s��|��q�5�2Q��G���%�#/s��4�d����wb2�>�CF]P��n�]Q쥁"( �i��T%Q�z�:�g��u-FgW�}����\Z�h�E����h���!,5�紡������h3H��f�f�Q`�� =�ߡ-B��zc����2�=�	�mj��~�	�����7g\F�0D7��ڧ�6�jD	h�Q�D9���i�t�5���<�&�h�-�V�Y}_ED��4��VDY��V��2�X pր��kSn���\lp\�Pjf�g"���ψ��T�W��JZ[)�O����hJ*dq$�N��(�U
+�OKv�2�.�&�}�*��� 9�"J����oi�ҊJ��7E�������2�*�8G�\E�f�І}M��'�C�{Ș(p�+�P�h�\!,����}�6}iz�� >Dd*�����8Z��,��k'�t D��T��Ҁ���� #M|n+'0L>��c)�_�H��eV���U��v��ۥ��󕷱2�V��N�ch�ܠ��)�����]8�E%��颁��A��H�π9�xE����gh�p�a�O��@A��)��;�B\ݦ�����*�wZʙHa��3�����4�#��u�[�5�>��(\+̚�!����$ߣ�mnN��#��v�v�7�ݏ�3�'��YRyV`���#j[(p��J�0��Y7"�"��0Q�!e��z�OԺ���	������˜�A[1�H���0z	ءB�]����!���'磚���i��@虿떹p�I`=�,H8 m����b�3�$�l�SP���*ӽ�#ʧ�@��H�p�A�yp�(!��)�C��R�Q�uo`��zվRO&��їy��31���+܎��[��%���6��mޞl!�#R3�`�&�WT�C��I�N:k@l���|� �}�:RX[��o���V��́���98�*?nV5/�"w�2p�%bF�@r1c��^;�i��7��"3��ht?�7�l`\@<w�S�Hp�H�
5��M�n��n�&5'�EO�1�`�X&1�Z���SE�� 
��|c���?�I� 0�z�yP�������Y<�.��,��n
�\��wjA GaE��JO8��bb��.,7聉]Qf�=2���ۮg����
I`��΀��8�V�$��ǟ�UJ�q�@O`��.�;�`��Ϯ�0 � �g��a+�̈́�zU���kId&��ƪW�vI�����Ƶ�R�Ct���SA����k��
��33�?h��Y/�<@��:���4�����5�Kп�FB�RޞL)�1 �1LmJ���c�+�pn:�
ˋ��G=������0*Bq&�H�[���=��}�6��0L4�S��R��� �����ܻ�s�u����k�q����H)�K��X�/��tؐI�[�}�B�*���
���:�(��Va�䌊�|3ۤ����F6\1�!P\����ru=����F��F7�����vD0�u.�d`/�y�@��������������ҙ^�[�]?n�zs�7��V���U �>5Q`�n_����,�p8]-*����r�/P�{3�2HVV℧��/h�&A�]��m(�OB}����~ڽ��%H���r������Llr�-���:�#�rY1L��h���O@};���W�����jpWtq�x����y����ҺW汰��\7����'%�_�s�G�UP�6�8|�Ͱ�)�&S�8]2����Ӫ2��!�\Y�����O(B���8����aX��F K��ś7o����     