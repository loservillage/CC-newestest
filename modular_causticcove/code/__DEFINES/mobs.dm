//The minimum goal required to achieve a goal mark.
#define NUTRITIONAL_GOAL 100

//The rates of decay.
#define DEFAULT_NUTRITIONAL_DECAY -0.025 // (0.025 / 2) * 60 * 30 = 22.5 over 30 minutes. 
#define MIN_REWARD_NUTRITIONAL_DECAY -0.02 // (0.02 / 2) * 60 * 30 = 18 over 30 minutes. 
#define FULL_REWARD_NUTRITIONAL_DECAY -0.01 // (0.02 / 2) * 60 * 30 = 9 over 30 minutes. 

//You can go a little over 100 as a means to keep your nutrition for longer. Going over all 5 goals and reaching over 100 will yield a very strong bonus and reduce nutritional drain.
//Why do we have a minimum? In case we ever decide to add detriments for not maintaining a balanced diet.
#define NUTRITIONAL_MIN_AMT 0
#define NUTRITIONAL_MAX_AMT 150

//Minimum amount of goals to reach to get rewarded the minimum reward.
#define NUTRITIONAL_REWARD_MIN 3 //Default 3

//Maximum amount of goals to reach to get rewarded the maximum reward. Typically relates to all current dietary goals.
#define NUTRITIONAL_REWARD_MAX 5 //Default 5

//Update this if you ever add any new types of diets. This generally will have little use outside of sanity.
#define NUTRITIONAL_DIET_TYPES list("Dairy", "Meats", "Fruits", "Vegetables", "Grains")

//Used for globally adjusting dietary values.
#define FOOD_DIETARY_VALUE_POOR 5
#define FOOD_DIETARY_VALUE_BAD 7
#define FOOD_DIETARY_VALUE_GOOD 11
#define FOOD_DIETARY_VALUE_GREAT 15
#define FOOD_DIETARY_VALUE_AMAZING 20
#define FOOD_DIETARY_VALUE_LEGENDARY 25

//Used specifically for reagents.
#define FOOD_DIETARY_REAGENT_VALUE_POOR 0.75
#define FOOD_DIETARY_REAGENT_VALUE_BAD 1
#define FOOD_DIETARY_REAGENT_VALUE_GOOD 2
#define FOOD_DIETARY_REAGENT_VALUE_GREAT 1.5
#define FOOD_DIETARY_REAGENT_VALUE_AMAZING 2
#define FOOD_DIETARY_REAGENT_VALUE_LEGENDARY 4

#define GOAL_COLOR_TERRIBLE "#ff0000"
#define GOAL_COLOR_BAD "#ff8800"
#define GOAL_COLOR_OKAY "#dcc300"
#define GOAL_COLOR_GOOD "#c3ff00"
#define GOAL_COLOR_ACHIEVED "#0fdc00"
#define GOAL_COLOR_MAXIMUM "#00eaff"
