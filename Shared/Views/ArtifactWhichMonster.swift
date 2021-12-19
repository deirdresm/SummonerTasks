//
//  ArtifactWhichMonster.swift
//  SummonerTasks
//
//  Designed in DetailsPro
//  Created by Deirdre Saoirse Moen on 12/19/21.
//

import SwiftUI

struct IconLabelView: View {
	var icon: String
	var text: String

	var body: some View {
		HStack {
			Image(icon)
				.renderingMode(.original)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 30, height: 30)
//				.clipped()
			Text(text)
				.frame()
//				.clipped()
				.padding(.trailing, 20)
				.fixedSize(horizontal: true, vertical: true)
		}
	}
}

struct ArtifactIconLabelView: View {
	var icon: String
	var text: String

	var body: some View {
		HStack {
			ZStack {
				Image("Images/artifacts/bg_legend.png")
					.renderingMode(.original)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(height: 40)
				Image(icon)
					.renderingMode(.original)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(height: 30)
			}
			Text(text)
		}
	}
}

struct ArtifactWhichMonster: View {
	var body: some View {
		ScrollView(.vertical, showsIndicators: true) {
			VStack {
				HStack {
					VStack(alignment: .leading) {
						Text("Attribute Artifact")
							.font(Font.system(.title2, design: .default).weight(.bold))
							.foregroundColor(Color.orange)
							.frame(maxWidth: .infinity, alignment: .leading)
							.clipped()
						HStack {
							IconLabelView(icon: "Images/elements/water.png", text: "Water")
							IconLabelView(icon: "Images/elements/fire.png", text: "Fire")
							IconLabelView(icon: "Images/elements/wind.png", text: "Wind")
							IconLabelView(icon: "Images/elements/light.png", text: "Light")
							IconLabelView(icon: "Images/elements/dark.png", text: "Dark")
						}
						.padding(.trailing)
					}
					VStack(alignment: .leading) {
						Text("Type Artifact")
							.font(Font.system(.title2, design: .default).weight(.semibold))
							.foregroundColor(Color.orange)
							.frame(maxWidth: .infinity, alignment: .leading)
							.clipped()
						HStack {
							HStack {
								ZStack {
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 40)
										.clipped()
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 30)
										.clipped()
								}
								Text("Attack")
							}
							.padding(.trailing, 20)
							HStack {
								ZStack {
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 40)
										.clipped()
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 30)
										.clipped()
								}
								Text("HP")
									.padding(.trailing, 20)
							}
							HStack {
								ZStack {
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 40)
										.clipped()
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 30)
										.clipped()
								}
								Text("Defense")
									.padding(.trailing, 20)
							}
							HStack {
								ZStack {
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 40)
										.clipped()
									Image("myImage")
										.renderingMode(.original)
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(height: 30)
										.clipped()
								}
								Text("Support")
							}
						}
						.padding(.trailing)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.clipped()
				}
				.frame(maxWidth: .infinity)
				.clipped()
				.padding()
				Text("Artifact Options")
					.padding(.vertical)
					.frame(maxWidth: .infinity)
					.clipped()
					.font(Font.system(.title2, design: .rounded).weight(.semibold))
					.foregroundColor(Color.orange)
			}
			.frame(maxWidth: .infinity)
			.clipped()
		}
	}
}

struct ArtifactWhichMonster_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactWhichMonster()
    }
}
