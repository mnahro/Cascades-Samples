/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import bb.cascades 1.0
import "Common"

// A recipe showing how the DropDown Control is used to make a selection.
// In this case different selection results in a recipe with different amounts of delicious beer.

Page {
    content: RecipeContainer {
        scrollMode: ScrollMode.Vertical

        layout: StackLayout {
            topPadding: 50
            rightPadding: topPadding
            leftPadding: rightPadding
        }

        Label {
            text: "Beer recipe"
            textStyle {
                base: SystemDefaults.TextStyles.BodyText
                color: Color.White
            }
        }

        // In the DropDown Control we add a number of options for selecting different values.
        // We use them later to check how many pints the recepie should make
        DropDown {
            id: dropdown

            // This is a custom property that is used by the recipe text below to present
            // appropiate meaures of ingredients depending on the selction made.
            property int nbrOfPints: 2
            title: "Number of pints"

            Option {
                value: 1
                text: value
            }
            Option {
                value: 2
                text: value
                selected: true
            }
            Option {
                value: 3
                text: value
            }
            Option {
                value: 4
                text: value
            }
            onSelectedIndexChanged: {
                // Here we access the selected option and update the nbrOfPints property
                // when a new selection has been made.
                var option = dropdown.at (selectedIndex);
                nbrOfPints = option.value;
            }
        }


        // The recipe text is built up from three texts. An text with the amount that
        // contain the different measures added to create the mix, an ingredients
        // text that is aligned to the amounts and a formula describing the process.
        Container {
            topMargin: 40

            Container {
                layout: StackLayout {
                    layoutDirection: LayoutDirection.LeftToRight
                }

                TextArea {
                    editable: false

                    // We use the nbrOfPints property in the dropdown above to present the amount of ingredients depending on the selection made.
                    text: dropdown.nbrOfPints / 10 + " kg\n" + dropdown.nbrOfPints * 1.0 + " g\n" + dropdown.nbrOfPints * 3 / 5 + " g\n" + dropdown.nbrOfPints * 1.5 + " l"
                    textStyle {
                        base: SystemDefaults.TextStyles.TitleText
                        color: Color.LightGray
                    }
                }

                TextArea {
                    editable: false
                    text: "Pale Ale Malt\nCascade Hops\nYeast\nWater"
                    textStyle {
                        base: SystemDefaults.TextStyles.TitleText
                        color: Color.LightGray
                    }
                }
            }

            ImageView {
                imageSource: "asset:///images/dropdown/beer" + dropdown.nbrOfPints
                scalingMethod: ScalingMethod.AspectFit
            }

            TextArea {
                editable: false
                text: "1. Mash at 67°C for 60 min\n2. Sparge\n3. Boil the wort for 90 min.\n4. Add hops after 30 min.\n5. Add yeast, ferment 1-2 weeks\n6. Add sugar and ferment in bottles for 1 week\n7. Serve"

                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    color: Color.LightGray
                }

                layoutProperties: StackLayoutProperties {
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
        }
    }
}