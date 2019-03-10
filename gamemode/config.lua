Config = {
    Supporter = {
        Rank = {
            "vip",
            "donator",
            "supporter",
            "superadmin"
        }
    },

	DefaultHealth = 1000,

    NoRedeemerSkill = true,

	NoSigilMap = {
	},

	NoSigilMLTMap = true,

	RedeemerClass = {
		{ 
			Model = "models/jazzmcfly/wrs/wrs.mdl",		--화이트 록 슈터
			Health = -150,
			Speed = 520,
			MaxSpeed = 520,
            JumpPower = 365,
			Regenerate = true,
			RegenDelay = 1,
			RegenHealth = 175,
			Weapons = {
				"weapon_zs_MLTkatana",
				"weapon_zs_swissarmyknife2"
			}
		},
		{ 
			Model = "models/jazzmcfly/brs/brs.mdl",		--블랙 록 슈터
			Health = 1350,
			Speed = 250,
			MaxSpeed = 280,
            JumpPower = 195,
			Regenerate = true,
			RegenDelay = 2,
			RegenHealth = 200,
			Weapons = {
				"weapon_zs_MLTgunblade",
				"weapon_zs_swissarmyknife2"
			}
		},
		{
			Model = "models/jazzmcfly/ibrs/ibrs.mdl",	--블랙 록 슈터 데빌버전
			Health = 3750,
			Speed = 115,
			MaxSpeed = 115,
            JumpPower = 160,
			Regenerate = true,
			RegenDelay = 4,
			RegenHealth = 675,
			Weapons = {
				"weapon_zs_MLTgunblade",
				"weapon_zs_swissarmyknife2"
			}
		}
	}

	StartingClass = {
		barrigater = {
			name = "바리게이터",
			health = 850,
			model = {
				"models/player/dod_american.mdl", 
				"models/player/dod_german.mdl"
			},

			weapon = {
				"weapon_zs_hammer",
				"weapon_zs_junkpack",
				"weapon_zs_messagebeacon"
			},

			ammo = {	
			}

		},

		medic = {
			name = "메딕",
			health = 1250,

			model = {
				"models/player/Group03m/male_01.mdl",
				"models/player/Group03m/male_02.mdl",
				"models/player/Group03m/male_03.mdl",
				"models/player/Group03m/male_04.mdl",
				"models/player/Group03m/male_05.mdl",
				"models/player/Group03m/male_06.mdl",
				"models/player/Group03m/male_07.mdl",
				"models/player/Group03m/male_08.mdl",
				"models/player/Group03m/male_09.mdl"
			},

			weapon = {
				"weapon_zs_medicgun",
				"weapon_zs_medicalkit",
				"weapon_zs_plank"
			},

			ammo = {

			}
		},

		tanker = {
			name = "탱커",
			health = 3750,
			model = {
				"models/player/combine_super_soldier.mdl",
				"models/player/combine_soldier_prisonguard.mdl",
				"models/player/combine_soldier.mdl"
			},

			weapon = {
				"weapon_zs_pipe"
			},
			
			ammo = {

			}

		}
	} // TODO: starting item 구현
}