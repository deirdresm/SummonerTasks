//
//  MonsterView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import SwiftUI

struct MonsterSkillView: View {
    let skills: [Skill]
    
    var body: some View {
        VStack {
            Text("Skills")
                .font(.headline)
            HStack {
                Spacer()
                
                ForEach(skills, id: \.self) { skill in
                    VStack() {
                        Text(skill.name ?? "")
                            .font(.subheadline)
                        Image(
                            ImageStore.loadImage(type: .skills, name: skill.imageFilename!),
                            scale: 2,
                            label: Text("")
                        )

                    }
                }
            }
        }
    }
}


struct MonsterSourceView: View {
    let sources: [Source]
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(sources, id: \.self) { source in
                Image(
                    ImageStore.loadImage(type: .icons, name: source.imageFilename!),
                    scale: 2,
                    label: Text("")
                )

            }
        }
    }
}

struct MonsterSkillupsView: View {
    let monster: Monster
    
    var body: some View {
        ZStack {
            Image(
                ImageStore.loadImage(type: .monsters, name: "devilmon_dark.png"),
                scale: 2,
                label: Text("")
            )
            Text("\(monster.skillUpsToMax)")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct LeaderSkillView: View {
    let monster: Monster
    
    var body: some View {
        if let leaderSkill = monster.leaderSkill {
            VStack {
                HStack {
                    Text("Leader Skill")
                        .font(.callout)
                        .fontWeight(.black)
                    Spacer()
                }
                HStack {
                    Image(
                        ImageStore.loadImage(type: .leaders, name: "\(leaderSkill.imageFileName()).png"),
                        scale: 2,
                        label: Text("")
                    )
                    .padding(.trailing)
                    Text(leaderSkill.leaderSkillString())
                    Spacer()
                }
            }
            .padding(.top)
            .padding(.leading)
        } else {
            EmptyView()
        }
    }
}

struct MonsterView: View {
    let monster: Monster
    
    var body: some View {
        let leaderSkill = monster.leaderSkill

        VStack {
            Text(monster.name!)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
            HStack(alignment: .top) {
                VStack {
                    MonsterIconView(monster: monster)
                    Spacer()
                }
                VStack {
                    HStack {
                        Text("Awakening Bonus:")
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                    HStack {
                        Text("Sources:")
                        Spacer()
                        MonsterSourceView(sources: monster.sourceArray)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                    HStack {
                        Text("Awakening Essences:")
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

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
                        Text("\(monster.maxLvlHp)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                    HStack {
                        Text("Attack:")
                        Spacer()
                        Text("\(monster.maxLvlAttack)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                    HStack {
                        Text("Defense:")
                        Spacer()
                        Text("\(monster.maxLvlDefense)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                    HStack {
                        Text("Speed:")
                        Spacer()
                        Text("\(monster.speed)")
                    }
                    Divider()
                    HStack {
                        Text("Crit Rate:")
                        Spacer()
                        Text("\(monster.critRate)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                    HStack {
                        Text("Crit Damage:")
                        Spacer()
                        Text("\(monster.critDamage)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                    HStack {
                        Text("Resistance:")
                        Spacer()
                        Text("\(monster.resistance)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))


                    HStack {
                        Text("Accuracy:")
                        Spacer()
                        Text("\(monster.accuracy)")
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
    }
}


// MARK: - Previews


struct MonsterView_Previews: PreviewProvider {

    static var previews: some View {
        MonsterView(monster: Monster.baleygr)
        .previewLayout(.fixed(width: 600, height: 800))
    }
}
