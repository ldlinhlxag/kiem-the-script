Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	=
{
	--�м��ؼ������·���
	biyuefeixingadd =
	{
		{
			RelatedSkillId = 787,
			magic =
			{
				missile_range =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
				},
			},
		},

		{
			RelatedSkillId = 492,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
			},
		},

		{
			RelatedSkillId = 148,
			magic =
			{
				missile_range =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}}},
				},
			},
		},
	},
	--�߼��ؼ���
	zhanrenadvancedbookadd =
	{
		{
			RelatedSkillId = 492,--��Ӱ׷��ǹ
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {10, -18*2.5}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {10, -18*2.5}}},
				},
			},
		},
		{
			RelatedSkillId = 787,--��Ӱ׷��ǹ
			magic =
			{
				state_zhican_attack =
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,40},{10,100}}},
					value2 = {SkillEnchant.OP_ADD,  {{1,2.5*18},{10,2.5*18}}},
				},
			},
		},
		{
			RelatedSkillId = 148,--ħ������
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
			},
		},

		{
			RelatedSkillId = 847,--�ɺ��޼�
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*15}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*15}}},
				},
			},
		},
	},
	--�м��ؼ�����ڤ����
	xuanmingxixingadd =
	{
		{
			RelatedSkillId = 494,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
				missile_range =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
				},
				missile_lifetime_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,18}, {10, 18*5}}},
				},
			},
		},

		{
			RelatedSkillId = 151,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}}},
				},
			},
		},

		{
			RelatedSkillId = 153,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)