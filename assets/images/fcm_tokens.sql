-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 15, 2023 at 11:54 AM
-- Server version: 5.7.40-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aa_hr_fms_services`
--

-- --------------------------------------------------------

--
-- Table structure for table `fcm_tokens`
--

CREATE TABLE `fcm_tokens` (
  `fcm_token_id` int(11) NOT NULL,
  `token` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_type` enum('web','android','ios') NOT NULL DEFAULT 'web',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fcm_tokens`
--

INSERT INTO `fcm_tokens` (`fcm_token_id`, `token`, `user_id`, `device_type`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(331, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-10-25 16:52:15', '2023-03-10 03:42:38', '2022-12-28 09:52:05'),
(332, 'dvSJOC0dDdOknaBvEpWLvb:APA91bEknlWGr6pRD4RHd0QZLJqYopej4f-fvNrbjk9ybJiP3_Nwg1zRWTHMMHVjgrFUy1b-9n6stGMx11KixdvPxmupfEFLz5JgOEgWI2LHjo9UgNvKssvE1OCdh23WGxT7E9aNm1tI', 114, 'web', 1, '2022-10-25 16:52:46', '2022-11-10 10:45:32', '2022-11-10 10:45:32'),
(333, 'dX9lKD2D_k6IpHi8HYyAvz:APA91bEYbMrjOp-6tOLNjR-fWnRYeJwEkBT8grf6GfiG49rQlM_tkVdydow0YYpbxQp7q2tyb3SEO0QjUS37bMR3QN4iV7CNr6C7TjYxP_fbGXWJmEUPw7A9dhyMfs-ArBV6htBuZf1E', 136, 'ios', 1, '2022-10-26 01:31:29', NULL, NULL),
(334, 'dKtNS962DQM2HnFVX2zKZQ:APA91bE3C6M8QgG9vYpP43Rx7nFUGjC56_eRXHzAF26Y0GcR6mz7uQGXpI3OLZvXmgjK1VpBvhiOsdRsqYhvoxroexAFM6Nd-b-ARWICcWqoOjFYNM5qJKROwtAsVPhVGTIoJxfuQYCN', 114, 'web', 1, '2022-10-26 02:08:06', '2022-10-27 02:46:15', '2022-10-27 02:46:15'),
(335, 'ev5hXqv5TNSHh2oQvgP9rP:APA91bF4V_wjXebtD738GWMgJcWg4ncSMsbbEAiSgruwGygp16P5PvJ4xs9EGCnLPRAo4jrgl3msSA7Dphh6tRUCBTWOzqmNFftfH4HybtUFNgCjodMWeEifSz6cXcRcip5T568gzoI8', 113, 'android', 1, '2022-10-26 02:49:48', '2023-03-03 10:09:16', NULL),
(336, 'ezlMlymzRZGN4_XwZN-cat:APA91bGP9POy8NgT9m9He_TypypH9T7JnPI8GJZBwYYFQZ-PhnEhNkcM367dMr--XanLCRkSmB_l3vuN2HbQXL7y2eOYh0a8p-1cg2jE1Bgt0zL58JEqDIpl7oZuDNRLKsh3PyKn6meP', 138, 'android', 1, '2022-10-26 03:02:32', NULL, NULL),
(337, 'd_TnepECdEnck05J90V4g_:APA91bGUVa-eYd1FcgYRpnrszvukriKbTnhdn9yWv3OY0O6HTUJv3rPP_RF17zl0BEBRHJFoX7EfVdG04-Yqg4crO1qnHhu9jaAcXQg7p-i93OrJHDDkB65mz0a-cyc452ut_UM4lA-I', 118, 'ios', 1, '2022-10-26 09:35:29', '2023-03-07 09:35:15', NULL),
(338, 'eitnS-IpST-g_uspOnioTH:APA91bFbsBDX0Oy16M1iA_ulR0Gkgt3MOxFMUARwF_5vVh_j2Os_-e3m963lDeU6drVWm9MtbXcuhzN3CBaAgXQoC1j8wRP7NGdfvzqJtN2_0Q51FgiL-yqXj0QpA9vM5-nsmemdBIEa', 115, 'android', 1, '2022-10-26 09:52:36', NULL, NULL),
(339, 'ftu4XCPQQc6FUDtpiTge_x:APA91bFtLY8XX6XhpmR8SYtXC9GIUTQeurvJyiNTpCf0axzVj4xhYntSM1RRXwvyAabFunxQArl0qJaG2_GOoq4F7zty1sMG3ctlJw2C-OKb0MUcNAvvaNdc83lB4rBcIP4HfhBo_yxt', 120, 'android', 1, '2022-10-26 10:01:12', NULL, NULL),
(340, 'eQSMlSULRcWpDLeMJD0F8t:APA91bGCt72ogx2dtnR4iyoUaEICtSG3HiwIQJmzIFB27mB-PoXIb27uxqJQOPxhip7x202tDABQYLNWOIDAZo4PieCZ1bAUMy8niBIYLWE4D-g5gHBCYGbZmwV6MCtHD5Q2dS9X3Lz0', 116, 'android', 1, '2022-10-26 10:05:59', '2023-03-03 09:29:03', NULL),
(341, 'cwJSFYlv8UV2rtzF75pbjh:APA91bHtFUtrg7kkRZ3pDuwWEb_gxmlu9Zmp2H_Z4Px8io36g1kOxMY5l9mua1OD6fpJAlO4TPXlgSEdbzilZwz3-sSVOw0DWw3Iev1xjUjGNsOJvVaJCsM6khpuVHziNtUSExrej9AW', 3, 'ios', 1, '2022-10-26 10:08:32', '2023-03-11 03:39:02', NULL),
(342, 'fTs3GH7v8goBabne8UzbN9:APA91bFbnAkYMRtnKrHel5AUno5rd9wKFS003dua3tSkKTN0_LwPd8c7ErqhO5_WL-pGX0a8Tib6yFLig1sQozzwQuY2Jhye3WiHEkZu0UdbNA14i67VE35qutiuEkZPn0yTxeNjDdew', 113, 'web', 1, '2022-10-26 10:12:02', NULL, NULL),
(343, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-10-27 03:56:03', '2023-03-10 03:42:38', '2022-10-27 04:43:42'),
(344, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-10-27 04:42:19', '2023-03-10 03:42:38', '2022-10-27 05:18:33'),
(345, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-10-27 05:17:44', '2023-03-10 03:42:38', '2022-10-29 02:16:52'),
(346, 'fO0tpuTpJNJxMoMKr6BBaD:APA91bGzTG4hfjrDN0YFuGs_X2HPhUvw2F2b8hmCIYY0cq7MjfR1BQogscjeSeqfi-Kd-2OzLtEu1TYhZRb5iT_F8ZfDYmLbIn4h1jac9_wlAgUBr1_ZpTZAmjeSSAoIo9IBIt2vzqH8', 5, 'web', 1, '2022-10-27 08:57:45', NULL, NULL),
(347, 'e1XLFgF8QZqLnh5f0rRJwu:APA91bFe1_OB1-Cxst-vJYPwshQSMWAHdkMqP0xkCTGO3c9UKJQFXUDqgf9W4GnIqby3PkCY4__0dPxHFIU-6r74UmuRWi4DG7i31kE71GLIP3sHGlNCTNdp_7PbCbpbOAK6sTyN59ln', 95, 'android', 1, '2022-10-30 16:25:00', NULL, NULL),
(348, 'd704CZhfJUgmj7ae_hjGud:APA91bGgj-QPDP3_xLALghnqx_09VZFpwlGj5_gWs2OgWQGXpeoN4-lpeKeyRrYljZtMXSqppomc35-HKnAcU4DHKVdaVhhkV_dzj-mzgzuJHl13alyMPL1vVm5AAQwHRiLPKSrBVOFY', 113, 'ios', 1, '2022-10-31 09:32:18', NULL, NULL),
(349, 'cr7rLTKAQ0ayZusHIinasa:APA91bHL08EfTtkQrm1BcPe2fjSeWjrKnW9BFRslokhvdqF-pgnz6a2HaeIdZ71zwHONS7ZJfEy2MWTNyoz5oUSbfN3NEnzLSSiP3ZY4PA8lcRKcTo69WeanV9TNHSLuW_6HXfkx-kqq', 44, 'android', 1, '2022-11-01 01:39:43', NULL, NULL),
(350, 'e8hI0iGkRDcT06XiGR0ZVj:APA91bFXrlCr3h3FLIgSNvqHQD0fJLojsu4D8j4tu-uck19wtI32sfOMmVLvxtf4MZACljuYDHlSohM2fRjOByeDEqt6Nr1IygyHEZir7gM8CR0zCTHS1VM1vuwLeWQLM79TYSkm6ubL', 138, 'web', 1, '2022-11-02 09:01:50', NULL, NULL),
(351, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-11-05 02:13:02', '2023-03-10 03:42:38', NULL),
(352, 'fCNOaCF4StCek9NTXn7hlU:APA91bGhoTbQpYqxfOlq65S6iPTLFqMGkMtC-q8sb3wxoP_BUAiWKEmn5CgGnbxDffBzb4k0gzFcyDAdMG4ul_K4cYDbs7RINocVodqIZaXJ9sPLC_DyhhephQMb_taPhHAFM_CkDPHK', 84, 'android', 1, '2022-11-08 05:33:34', NULL, NULL),
(353, 'fCNOaCF4StCek9NTXn7hlU:APA91bGhoTbQpYqxfOlq65S6iPTLFqMGkMtC-q8sb3wxoP_BUAiWKEmn5CgGnbxDffBzb4k0gzFcyDAdMG4ul_K4cYDbs7RINocVodqIZaXJ9sPLC_DyhhephQMb_taPhHAFM_CkDPHK', 84, 'android', 1, '2022-11-08 05:33:34', NULL, NULL),
(354, 'dOsFco8qlb3j_z11sCl7de:APA91bGO7VFl2grIMa__D6n9eGGJJYZ5aNRjShwdwtfA7NnqJTiDkwpbZlX0a79ZkPBhWzDW4tA8ozsZiWs5Fcz0c6OcivXrHFHX0d8dBUCsYIVraExCkWMKAK-XdV2QZBXmEBTW4XS2', 114, 'web', 1, '2022-11-08 07:14:17', NULL, NULL),
(355, 'dvzXhodSxKDw6WoaAbsI_q:APA91bEG3FNb_aukFTVc8D6cGUXjLvbCWBaiSVXpMI8e4e_-EyXSzXI76dRaZodBacNZSdeuXDoQwQHr0d95tssvDjXEHIu5e0WzWnHRdQSGTLMd0CPaPIHfu_EeVrBRYKG-P5mDNAk3', 120, 'web', 1, '2022-11-10 09:22:49', NULL, NULL),
(356, 'cgTsCqwQv-00Aw9bOlsyov:APA91bHP44UWFMTrjaj1IDyBeGXvH26OUOLjXEIJdxKKIpdRCCCscJLlyDlS3ouiEk64iwFVqzOLBnX7z08NimFTyFYmRd6_Wv_GtUlC-hSShVdASftsXGuLFawtM-hR1sxoeMX5Wxtg', 139, 'web', 1, '2022-11-11 03:23:37', NULL, NULL),
(357, 'ekT5i7btQSWNu8hgTfORpE:APA91bE_9nbzeWfXBxSw3Vz6GzS50Tv7Qu1D0SPwoFqlOGUYXOxXsgB9N726dQsoz2e7uJIP2v0cHILQJ9_l33_4qq3zzrMjE3y8eK0JLJnaNwOPA66qEGrkaYnT4J-84-51NUH8hZ1T', 82, 'android', 1, '2022-11-14 15:27:46', NULL, NULL),
(358, 'eM7WwxLQfUaasQ9DcIF063:APA91bGx2_S9VtEJL6IMIceucnf4EccgH_oRBv9X9Kl27XagESauNokjBsQc0OSD_Y-yP0S8N2eGP92QCU4xjnzG-uE-6GneKy6m_osmLpW4xB1qR0JmCcKRmSPPk_bqBqIreaCVkIOT', 137, 'ios', 1, '2022-11-17 06:01:39', NULL, NULL),
(359, 'cmUPAPWtSI2_SyAF6VQiuN:APA91bF4N4GS3vWSC1Sx3tk8v_IXsQQFrypXu75y1zPGrMzMjXv7KgTqI51YWxnRTSVSKuRAtW_Q9-mZJXNNT2yaftSVNxF3nSYpwt67fFPHbFVma2_bS3aq2JnQr_1Nfe8RUmC7woeg', 140, 'android', 1, '2022-11-21 03:13:12', NULL, NULL),
(360, 'e8kVCYcLsR6tvm-_zReUoB:APA91bEXdV8LT5sxvnepggPPIpa6QNrW3I_GsVfa7o9KZ63UDmrxxhve-U5aoHUmfPWdA70t80TkVqD8tCKXFyg6IFw5MguabA-W9T_c6_eFgwM8YRA7Su2t52wsLIDfaROCfVGWt9hI', 140, 'web', 1, '2022-11-21 03:16:42', NULL, NULL),
(361, 'eTzdSbl52kd6tP487wH8Hf:APA91bGfzRth9FbeVumAU3SYLAVPDoWGaLZS4OZ__lUudPhuq-peI6TE9OjHeKK-QmbP3vM5MpuBnBQ12HdKxdTPa0a4HK7PFBXIPRj00ZZoK8pcUucADgEFXeJ47i6-VE1AMb7bHBrN', 114, 'ios', 1, '2022-11-22 04:14:27', '2023-03-04 04:02:12', NULL),
(362, 'cZjNaCA10bba73smlhRYRt:APA91bGXXjaK83or8eZijG31FZ0rnSAgNcAT3-J-AmV0TYPkBeSO1YA-r4TNtVK3KDbpMxKiFO0RHFpemAmT4hPqdpuwQbxdgkz30rlHqtq0UXPsXcY24yqYxfiTbidQqtbuGajcmX7_', 28, 'web', 1, '2022-11-22 07:21:02', NULL, NULL),
(363, 'cMGKTgYqJAVXNmWbHb7LNx:APA91bFLv8JN_hzLNcnIze_rnmtJpMMKRtbeCiB-mNK_sakGonb51EeCb4VnQvaixTDyctb1dsDirx9z96sUWT45ErQWAschmKSg1ZPmu1HxlfJABTo9Gn6f7P9Y0hgcDI56O3v2-9Za', 108, 'web', 1, '2022-11-22 07:26:58', NULL, NULL),
(364, 'frSQta98JNaMfAK3WfxzR-:APA91bFRE5PmXt0gshuLzp-t39HaDfG6PRPkfAzYFzSwUnRzFqIvMDmFmQrskTQq6mU9O3WL2WEeVikv_jk0qhDjPrb3Qi9uipzSa_JIEiuEA3cZs86Sxoo-koKWN-io9A85YlpMPXsR', 18, 'web', 1, '2022-11-22 07:49:17', NULL, NULL),
(365, 'eTzdSbl52kd6tP487wH8Hf:APA91bGfzRth9FbeVumAU3SYLAVPDoWGaLZS4OZ__lUudPhuq-peI6TE9OjHeKK-QmbP3vM5MpuBnBQ12HdKxdTPa0a4HK7PFBXIPRj00ZZoK8pcUucADgEFXeJ47i6-VE1AMb7bHBrN', 114, 'ios', 1, '2022-11-25 03:54:49', '2023-03-04 04:02:12', NULL),
(366, 'eTzdSbl52kd6tP487wH8Hf:APA91bGfzRth9FbeVumAU3SYLAVPDoWGaLZS4OZ__lUudPhuq-peI6TE9OjHeKK-QmbP3vM5MpuBnBQ12HdKxdTPa0a4HK7PFBXIPRj00ZZoK8pcUucADgEFXeJ47i6-VE1AMb7bHBrN', 114, 'ios', 1, '2022-11-26 14:40:46', '2023-03-04 04:02:12', NULL),
(367, 'cs8KAD1oH5oE618P9hKl4E:APA91bGFkwWnh86P0hfzHY9MdAnvQI1Z1Kz3AA_w2zGzUyyFejusSfC2_qNCBZsnBpH_rS84OhDYKIhkXibQMIe7yEO3Hw3zcbKaeFW7evve-SNfhdJXys36S79zpdpApG8NTzIZow9e', 113, 'web', 1, '2022-11-29 07:13:47', NULL, NULL),
(368, 'ct882GFzQImntIhtp8Uwh-:APA91bHoimkPVtdSVfWKTfavTeOpC4QDviPwB9MfoqHeAWzjvrwbqorILGB4-i-UZr0PBvPWvQv8IwYDKi8djtnObokIiANN47jOA4dX6iWia1c60wjbyGxBKgQ2iqj2czdi0PyIBT6O', 47, 'android', 1, '2022-12-11 07:29:32', NULL, NULL),
(369, 'dxJXOUn3S8eg0JdJapT2oQ:APA91bEor1xvs5f7McrE20ARzEMTl3a92d2Z7cfHWXMNFcoTzX8Ss53SY2ypDT-1oQhgQsnXS74N3H5TjvG1-DcHqiPQOqsYIg9_9imYw6kCib9AIPfbmKQZsNEpcSeCJtHfxu6uQAiZ', 136, 'android', 1, '2022-12-12 01:03:05', NULL, NULL),
(370, 'eQSMlSULRcWpDLeMJD0F8t:APA91bGCt72ogx2dtnR4iyoUaEICtSG3HiwIQJmzIFB27mB-PoXIb27uxqJQOPxhip7x202tDABQYLNWOIDAZo4PieCZ1bAUMy8niBIYLWE4D-g5gHBCYGbZmwV6MCtHD5Q2dS9X3Lz0', 116, 'android', 1, '2022-12-13 08:26:56', '2023-03-03 09:29:03', NULL),
(371, 'dA0kC0OAR76vr75-hTzEgJ:APA91bFaI0-olpLhtxsYEgh6DuwFyUr8TnmyEzMldUKJV5NCyi9HKhkVTjCA3Pz1Ao8BNEFwuIUd8JXnitqUGiyXs4v2wZ_Z2TZlzzYtcje8d5ChmLx318zsViBGUX9lc4LJ2d4WDT-m', 55, 'android', 1, '2022-12-20 04:26:17', NULL, NULL),
(372, 'd6JPkTftRUign8nzKmADW0:APA91bHGhzleYrM_JJr_pDT4oTM8wTTJ7VJFDbzFfCKi6TusX7Ft8tsxHFZ3jes78rG8yksGIv-NNAni3g1ZnSFynktENEdi--5NjLNLtMe-07dKeEJwsymw7zaZU1skJGOLGGkOGeR9', 114, 'android', 1, '2022-12-23 10:56:48', '2023-03-10 03:42:38', NULL),
(373, 'eX7HrpekSkCJh8EyYgHI7Y:APA91bE-Sd05T-65IUErQ6jpUhcphQCGe5aE3pA9LLJeEVQkoyaGVGHwMxhGLJ-gFWP8aoKTm5FMHE2QCHpw5Kod9OHtYbiGYyCTyCoCNcMrx9tuQ1Jvf4GRhIOYBSrpbhRJlrJI9f_E', 49, 'android', 1, '2022-12-28 10:01:21', NULL, NULL),
(374, 'euQ_B3RTQGeDXngxzrCiYS:APA91bEm6FfWKLBK3sZixWt5j6ankMzSPWh70u_Hqt9O93PCzFZL78OewjLRY3chXR02rQTAoc-NiUPjivuEwP3-uN3fbik9xOlmdaLZxm7SFHri1m0pq4A3_MDa2dZxz0ah7kMhMHXN', 138, 'android', 1, '2023-02-08 08:50:21', NULL, NULL),
(375, 'd8W_9x1ib0jVuZ18nz8UGF:APA91bFCPQS4q9VgTqw-IQEPUaqLSIS7X2_cnTDXWN_9kWd3vhfbLrcuT1kjdnzzk0u4fnKPnHlXt-aMvVBDPAVtHiR76TY_S5wRQD3YdZQurPE5vRjh4nOB1oWPB2eU2L0ZthMXXIOb', -1, 'ios', 1, '2023-03-04 06:44:29', '2023-03-10 12:58:04', NULL),
(376, 'd1aT9pCKgUBZogdTWVjZrq:APA91bEg1H6xnkc326ZcEW-WhxcdH8Baun7mC8GV0-zvacimTq2j5Av1X-xeg3MSL0cvI1p3pmnTAlt1YF7W1BcHj1k-pA3vTs95xlcgwjTJ2F9NENx1T6lxRzE2u71MgGE7Xvki-eo4', 145, 'ios', 1, '2023-03-06 04:00:35', NULL, NULL),
(377, 'ey_r0HzwpsVpz34XgX1FnG:APA91bEhbF7pl3N7Kaw6nFnnIVxQvSlSRqk8zVnzpLk8m7QTatyCAXNxxis8-86Dfs6if737FkqGfocigtHEp3XduL44B_0iydD_TqS1Jd7vnXC1FezGNujavzTDsJ0OSGR3ymrghaNt', 145, 'web', 1, '2023-03-06 04:01:23', NULL, NULL),
(378, 'eyGISnbDQDuLa6Pr6TBUDP:APA91bG6N9hpb_FlLsK8gxe_-W4zs1DT1bsYFm8EfQKNGv9Ka2xt4vwj7J-37kobnvzGfk5sHesq9SBrTH8lZB8lC8jaPTJzaQnG-jPAqybn8Y_sRfE2tlZxEqdP_FOXeTm1jHlI9e-m', 102, 'android', 1, '2023-03-10 02:18:11', NULL, NULL),
(379, 'eSiQyMu3KUkAjI64iuoQRw:APA91bGcIw2HcchG5NW2AXcThJ8eGAo3q_miiiM3os7twXpu1391GoDHDEgqcOkJfYhcloFBxqvNzhbi4D44A02yy-lgtRMurb2I8CKGkZL-NOreyBQoVLykj08CjaNiHc-AP1JOqPI3', 139, 'ios', 1, '2023-03-11 03:47:15', NULL, NULL),
(380, 'eSiQyMu3KUkAjI64iuoQRw:APA91bGcIw2HcchG5NW2AXcThJ8eGAo3q_miiiM3os7twXpu1391GoDHDEgqcOkJfYhcloFBxqvNzhbi4D44A02yy-lgtRMurb2I8CKGkZL-NOreyBQoVLykj08CjaNiHc-AP1JOqPI3', 139, 'ios', 1, '2023-03-11 03:47:15', NULL, NULL),
(381, 'eQpwBm3cSIm0OBBKlKJ_q0:APA91bHJGI0eyViyexgYvvmcM-9V1XdnUte45rlnHg1EBHTTIcrc2_MvTSYwceuSOax_0E5TRZ4OLbu2qdB2hksRoMzpeOS-uUC_VMy1WAWdQ3we8D_X4U7aM3sLo4xowIDJ0nMso5Xa', 12, 'android', 1, '2023-03-11 03:52:54', NULL, NULL),
(382, 'e0y4bR2iXQAng-bFJQxK7a:APA91bG1nbtkXAJlB5Pcyz2ZAmc3YA9U4WfEOdj1OP0koj93fzIL8yuXC0Tt8GFmCO9fA6EGMdD16jjIz8U7dF3kJEivDMcwapGGGTJ_IBm7LsSztv1Ag2v23PdGHv41y_55-aAOC17J', 117, 'web', 1, '2023-03-11 04:00:08', NULL, NULL),
(383, 'e3NDUmTbL73tfxTtmudO0o:APA91bEQykc7lvvQ2cFs524p55nIPIkXp9eQYguMQ9XxY12uE_ZnfOfUl45Et5u6Hafgc-mH4juYqcNl8X8HtFblN9ECyhV0zBcOTm_hpCC0x_txJIIqiWtC6exDQdz_0qw5jpC5gok9', 12, 'web', 1, '2023-03-11 04:00:38', NULL, NULL),
(384, 'ekvQ5NwZzi7QC-59j_3j24:APA91bFq6ghXg4QZkTgrEOpWjAT6cPBt0o1g0To_5UPdnkkJ-oZgX1L5WKeQNdqw3DaCxuzeuPq27eREq_xdjo2xv_nNYv47XLuvTQrFe-NB6Lp_4QIADiH50QWxh9ALQoXO78F4togA', 38, 'web', 1, '2023-03-11 04:42:54', NULL, NULL),
(385, 'dKxk_YivRmKghcRnS0QUfT:APA91bED-aXK9SyruEi0-yM2DuklkkUNaOq39w70Vi3y0zexOlj2imvYTJKC8u4YMxB41IlyL94YftrRiRXrhT8EJWyqcm-VQo4gNQ7klnZZaRNpGhSS5MqZ1u2TiDcuQMFzF0nIVfd6', 38, 'android', 1, '2023-03-11 05:43:19', NULL, NULL),
(386, 'dKxk_YivRmKghcRnS0QUfT:APA91bED-aXK9SyruEi0-yM2DuklkkUNaOq39w70Vi3y0zexOlj2imvYTJKC8u4YMxB41IlyL94YftrRiRXrhT8EJWyqcm-VQo4gNQ7klnZZaRNpGhSS5MqZ1u2TiDcuQMFzF0nIVfd6', 38, 'android', 1, '2023-03-11 05:43:19', NULL, NULL),
(387, 'dbD60_HnQsieT7-vj0QPzE:APA91bHBRdFPYlO88RNcORPRCrhBK9afEcSATJqCqGo-7tv4s9xGHMnxYem2kNM0uylKOiSlLalg5rDcnaG5MI6c900bCqk47d1yd3oiTsvC0oIJ87HAJSwcDg_4ZWLh_EBlfwxwWaJn', 117, 'android', 1, '2023-03-13 07:06:51', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  ADD PRIMARY KEY (`fcm_token_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  MODIFY `fcm_token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=388;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
