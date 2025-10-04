Item.DROP_DETAIL_TYPE                   = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

Item.DROP_ITEM_MELEE_DETAIL_TYPE        = 1;
Item.DROP_ITEM_RANGE_DETAIL_TYPE        = 2;
Item.DROP_ITEM_ARMOR_DETAIL_TYPE        = 3;
Item.DROP_ITEM_RING_DETAIL_TYPE         = 4;
Item.DROP_ITEM_NECKLACE_DETAIL_TYPE     = 5;
Item.DROP_ITEM_AMULET_DETAIL_TYPE       = 6;
Item.DROP_ITEM_BOOTS_DETAIL_TYPE        = 7;
Item.DROP_ITEM_BELT_DETAIL_TYPE         = 8;
Item.DROP_ITEM_HELM_DETAIL_TYPE         = 9;
Item.DROP_ITEM_CUFF_DETAIL_TYPE         = 10;
Item.DROP_ITEM_PENDANT_DETAIL_TYPE      = 11;
Item.DROP_ITEM_HORSE_DETAIL_TYPE        = 12;

Item.DROP_ITEM_MELEE_PARTICULAR_TYPE    = { 1, 2, 3, 4, 5, 6 };
Item.DROP_ITEM_RANGE_PARTICULAR_TYPE    = { 1, 2, 3 };
Item.DROP_ITEM_ARMOR_PARTICULAR_TYPE    = { 2, 3, 4, 6, 7, 8 };
Item.DROP_ITEM_RING_PARTICULAR_TYPE     = { 1 };
Item.DROP_ITEM_NECKLACE_PARTICULAR_TYPE = { 1 };
Item.DROP_ITEM_AMULET_PARTICULAR_TYPE   = { 1 };
Item.DROP_ITEM_BOOTS_PARTICULAR_TYPE    = { 1, 2 };
Item.DROP_ITEM_BELT_PARTICULAR_TYPE     = { 1, 2 };
Item.DROP_ITEM_HELM_PARTICULAR_TYPE     = { 2, 3, 4, 6, 7, 8 };
Item.DROP_ITEM_CUFF_PARTICULAR_TYPE     = { 1, 2 };
Item.DROP_ITEM_PENDANT_PARTICULAR_TYPE  = { 1, 2 };
Item.DROP_ITEM_HORSE_PARTICULAR_TYPE    = { 1, 2 };

Item.MAGIC_DESC                         = {
    ["lifereplenish_v"]     = { description = "Mỗi 5s hồi phục sinh lực", value = false },
    ["damage2addmana_p"]    = { description = "Chịu sát thương chuyển hóa thành nội lực", value = false },
    ["attackspeed_v"]       = { description = "Tốc độ xuất chiêu ngoại công", value = false },
    ["addphysicsmagic_p"]   = { description = "Vật công nội", value = false },
    ["addphysicsdamage_p"]  = { description = "Vật công ngoại", value = false },
    ["addlightingdamage_v"] = { description = "Lôi công ngoại", value = false },
    ["addlightingmagic_v"]  = { description = "Lôi công nội", value = false },
    ["steallife_p"]         = { description = "Hút sinh lực", value = true },
    ["stealmana_p"]         = { description = "Hút nội lực", value = true },
    ["fastwalkrun_p"]       = { description = "Tốc độ di chuyển", value = true }
}

Item.MAGIC_VALUABLE_COMBO               = {
    { "addphysicsdamage_p", "stealmana_p" },
    { "addphysicsdamage_p", "steallife_p" },
    { "addphysicsdamage_p", "addlightingdamage_v" },
    { "addphysicsmagic_p", "addlightingmagic_v" },
}

Item.RARITY                             = {
    COMMON    = "Common",
    UNCOMMON  = "Uncommon",
    RARE      = "Rare",
    EPIC      = "Epic",
    LEGENDARY = "Legendary",
}

Item.EQUIP_MELEE_WEAPON                 = 1;  -- 近程武器
Item.EQUIP_RANGE_WEAPON                 = 2;  -- 远程武器
Item.EQUIP_ARMOR                        = 3;  -- 衣服
Item.EQUIP_RING                         = 4;  -- 戒指
Item.EQUIP_NECKLACE                     = 5;  -- 项链
Item.EQUIP_AMULET                       = 6;  -- 护身符
Item.EQUIP_BOOTS                        = 7;  -- 鞋子
Item.EQUIP_BELT                         = 8;  -- 腰带
Item.EQUIP_HELM                         = 9;  -- 头盔
Item.EQUIP_CUFF                         = 10; -- 护腕
Item.EQUIP_PENDANT                      = 11; -- 腰坠
Item.EQUIP_HORSE                        = 12; -- 马匹
Item.EQUIP_MASK                         = 13; -- 面具
Item.EQUIP_BOOK                         = 14; -- 秘籍
Item.EQUIP_ZHEN                         = 15; -- 阵法
Item.EQUIP_SIGNET                       = 16; -- 印章
Item.EQUIP_MANTLE                       = 17; -- 披风
Item.EQUIP_CHOP                         = 18; -- 官印
Item.EQUIP_PARTNERWEAPON                = 19; -- 同伴武器
Item.EQUIP_PARTNERBODY                  = 20; -- 同伴衣服
Item.EQUIP_PARTNERRING                  = 21; -- 同伴戒指
Item.EQUIP_PARTNERCUFF                  = 22; -- 同伴护腕
Item.EQUIP_PARTNERAMULET                = 23; -- 同伴护身符
Item.EQUIP_ZHENYUAN                     = 24; -- 真元
Item.EQUIP_GARMENT                      = 25; -- 外衣
Item.EQUIP_OUTHAT                       = 26; -- 外帽
Item.EQUIP_SOULSIGNET                   = 27; -- »êÓ¡ <-add

Item.SERIES_MAP                         = {
    [Env.SERIES_METAL] = {
        [Item.EQUIP_HELM] = Env.SERIES_METAL,
        [Item.EQUIP_MELEE_WEAPON] = Env.SERIES_METAL,
        [Item.EQUIP_RANGE_WEAPON] = Env.SERIES_METAL,
        [Item.EQUIP_CUFF] = Env.SERIES_WOOD,
        [Item.EQUIP_PENDANT] = Env.SERIES_WOOD,
        [Item.EQUIP_BOOTS] = Env.SERIES_WATER,
        [Item.EQUIP_AMULET] = Env.SERIES_WATER,
        [Item.EQUIP_BELT] = Env.SERIES_FIRE,
        [Item.EQUIP_RING] = Env.SERIES_FIRE,
        [Item.EQUIP_ARMOR] = Env.SERIES_EARTH,
        [Item.EQUIP_NECKLACE] = Env.SERIES_EARTH,
    },
    [Env.SERIES_WOOD] = {
        [Item.EQUIP_HELM] = Env.SERIES_WOOD,
        [Item.EQUIP_MELEE_WEAPON] = Env.SERIES_WOOD,
        [Item.EQUIP_RANGE_WEAPON] = Env.SERIES_WOOD,
        [Item.EQUIP_CUFF] = Env.SERIES_EARTH,
        [Item.EQUIP_PENDANT] = Env.SERIES_EARTH,
        [Item.EQUIP_BOOTS] = Env.SERIES_FIRE,
        [Item.EQUIP_AMULET] = Env.SERIES_FIRE,
        [Item.EQUIP_BELT] = Env.SERIES_METAL,
        [Item.EQUIP_RING] = Env.SERIES_METAL,
        [Item.EQUIP_ARMOR] = Env.SERIES_WATER,
        [Item.EQUIP_NECKLACE] = Env.SERIES_WATER,
    },
    [Env.SERIES_WATER] = {
        [Item.EQUIP_HELM] = Env.SERIES_WATER,
        [Item.EQUIP_MELEE_WEAPON] = Env.SERIES_WATER,
        [Item.EQUIP_RANGE_WEAPON] = Env.SERIES_WATER,
        [Item.EQUIP_CUFF] = Env.SERIES_FIRE,
        [Item.EQUIP_PENDANT] = Env.SERIES_FIRE,
        [Item.EQUIP_BOOTS] = Env.SERIES_WOOD,
        [Item.EQUIP_AMULET] = Env.SERIES_WOOD,
        [Item.EQUIP_BELT] = Env.SERIES_EARTH,
        [Item.EQUIP_RING] = Env.SERIES_EARTH,
        [Item.EQUIP_ARMOR] = Env.SERIES_METAL,
        [Item.EQUIP_NECKLACE] = Env.SERIES_METAL,
    },
    [Env.SERIES_FIRE] = {
        [Item.EQUIP_HELM] = Env.SERIES_FIRE,
        [Item.EQUIP_MELEE_WEAPON] = Env.SERIES_FIRE,
        [Item.EQUIP_RANGE_WEAPON] = Env.SERIES_FIRE,
        [Item.EQUIP_CUFF] = Env.SERIES_METAL,
        [Item.EQUIP_PENDANT] = Env.SERIES_METAL,
        [Item.EQUIP_BOOTS] = Env.SERIES_EARTH,
        [Item.EQUIP_AMULET] = Env.SERIES_EARTH,
        [Item.EQUIP_BELT] = Env.SERIES_WATER,
        [Item.EQUIP_RING] = Env.SERIES_WATER,
        [Item.EQUIP_ARMOR] = Env.SERIES_WOOD,
        [Item.EQUIP_NECKLACE] = Env.SERIES_WOOD,
    },
    [Env.SERIES_EARTH] = {
        [Item.EQUIP_HELM] = Env.SERIES_EARTH,
        [Item.EQUIP_MELEE_WEAPON] = Env.SERIES_EARTH,
        [Item.EQUIP_RANGE_WEAPON] = Env.SERIES_EARTH,
        [Item.EQUIP_CUFF] = Env.SERIES_WATER,
        [Item.EQUIP_PENDANT] = Env.SERIES_WATER,
        [Item.EQUIP_BOOTS] = Env.SERIES_METAL,
        [Item.EQUIP_AMULET] = Env.SERIES_METAL,
        [Item.EQUIP_BELT] = Env.SERIES_WOOD,
        [Item.EQUIP_RING] = Env.SERIES_WOOD,
        [Item.EQUIP_ARMOR] = Env.SERIES_FIRE,
        [Item.EQUIP_NECKLACE] = Env.SERIES_FIRE,
    },
}
