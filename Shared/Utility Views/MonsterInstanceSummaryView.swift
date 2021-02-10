//
//  MonsterInstanceSummaryView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/31/20.
//


import Foundation
import SwiftUI

// TODO: genericize this so it can handle either a Monster or MonsterInstance
struct MonsterInstanceSkillupsView: View {
    let monsterI: MonsterInstance
    
    var skillups: Int64 {
        if let monster = monsterI.monster {
            var skillups = monster.skillUpsToMax
            
            if monsterI.skill1Level > 0 {
                skillups = skillups - monsterI.skill1Level + 1
            }
            if monsterI.skill2Level > 0 {
                skillups = skillups - monsterI.skill2Level + 1
            }
            if monsterI.skill3Level > 0 {
                skillups = skillups - monsterI.skill3Level + 1
            }
            if monsterI.skill4Level > 0 {
                skillups = skillups - monsterI.skill4Level + 1
            }
            return skillups
        }
        return 0
   }

    var body: some View {
        ZStack {
            Image(
                ImageStore.loadImage(type: .monsters, name: "devilmon_dark.png"),
                scale: 2,
                label: Text("")
            )
            Text("\(skillups)")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct MonsterInstanceSummaryView: View {
    let monsterI: MonsterInstance
    
    var body: some View {
        if let monster = monsterI.monster {
            let hp = monster.maxLvlHp + monsterI.runeHp + monsterI.artifactHP
            let atk = monster.maxLvlAttack + monsterI.runeAttack + monsterI.artifactAttack
            let def = monster.maxLvlDefense + monsterI.runeDefense + monsterI.artifactDefense
            let speed = monster.speed + monsterI.runeSpeed
            let critRate = monster.critRate + monsterI.runeCritRate
            let critDamage = monster.critDamage + monsterI.runeCritDamage
            let resist = monster.resistance + monsterI.runeResistance
            let acc = monster.accuracy + monsterI.runeAccuracy
            
            let leaderSkill = monster.leaderSkill
            VStack {
                Text(monster.name ?? "Could not fetch monster name")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                HStack(alignment: .top) {
                    VStack {
                        MonsterIconView(monster: monster)
                        Spacer()
                        HStack {
                            Text("Skill-Ups to Max:")
                            Spacer()
                            MonsterSkillupsView(monster: monster)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                    
                    VStack {
                        HStack {
                            Text("HP:")
                            Spacer()
                            Text("\(hp)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                        HStack {
                            Text("Attack:")
                            Spacer()
                            Text("\(atk)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                        HStack {
                            Text("Defense:")
                            Spacer()
                            Text("\(def)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                        HStack {
                            Text("Speed:")
                            Spacer()
                            Text("\(speed)")
                        }
                        Divider()
                        HStack {
                            Text("Crit Rate:")
                            Spacer()
                            Text("\(critRate)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                        HStack {
                            Text("Crit Damage:")
                            Spacer()
                            Text("\(critDamage)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                        HStack {
                            Text("Resistance:")
                            Spacer()
                            Text("\(resist)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                        HStack {
                            Text("Accuracy:")
                            Spacer()
                            Text("\(acc)")
                        }
                    }
                    .padding(.top)
                }
                .frame(minWidth: 500, maxWidth: 700, minHeight: 200, maxHeight: 300)
                Divider()
                LeaderSkillView(monster: monster)
                Spacer()
                MonsterSkillView(skills: monster.skillsSorted)
            }
        } else {
            EmptyView()
        }
    }
}


// MARK: - Previews


struct MonsterInstanceSummaryView_Previews: PreviewProvider {

    static var previews: some View {
        MonsterInstanceSummaryView(monsterI: MonsterInstance.baleygr)
        .previewLayout(.fixed(width: 600, height: 800))
    }
}
