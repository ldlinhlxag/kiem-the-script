-------------------------------------------------------------------
--File: playerprofile.lua
--Author: Brianyao
--Date: 2008-9-24 10:39
--Describe: ������Ϣ����
-------------------------------------------------------------------
local preEnv = _G	--����ɵĻ���
setfenv(1, PProfile)	--���õ�ǰ����ΪPProfile

--����ֵ������ kplayerprofileagentprotocol.h ��ͬ���������Χ��ȡֵ����Щֵ�������ݱ��޸ĵ�ʱ�����ж�
MAX_REAL_NAME_LEN=12    --��ʵ������󳤶�
MAX_NICK_NAME_LEN=12    --�ǳ���󳤶�
MAX_PROFESSION_LEN=12   --ְҵ��󳤶�
MAX_SLEFTIPS_LEN=20     --��ͷ��
MAX_CITY_LEN=10         --����
MAX_FAVOR_LEN=160       --����
MAX_BLOG_LEN=40         --���͵�ַ
MAX_DIARY_LEN=200       --���

--���һ���ַ�����¼���в�����ö��
emPF_BUFTASK_NAME=1      --����
emPF_BUFTASK_AGNAME=2    --�º�
emPF_BUFTASK_PROFESSION=3  --ְҵ
emPF_BUFTASK_CITY=4       --��ס����
emPF_BUFTASK_TAG=5        --��ͷ��
emPF_BUFTASK_FAVORITE=6   --����
emPF_BUFTASK_BLOGURL=7    --���͵�ַ
emPF_BUFTASK_COMMENT=8    --���

--���INTֵ��¼���в�����ö��
emPF_TASK_SEX=1                              --�Ա�
emPF_TASK_BIRTHD=2                           --����
emPF_TASK_REINS=3                            --���飬��ö�ٹ��ɣ�����ѡ��
emPF_TASK_ONLINE=4                           --��������ʱ�䣬�����빹�ɣ����Զ�ѡ
emPF_TASK_FRIEND_ONLY=5                      --�Ƿ�����Ǻ��ѿɼ�
ememPF_TASK_VER=6                            --�汾��

preEnv.setfenv(1, preEnv)	--�ָ�ȫ�ֻ���