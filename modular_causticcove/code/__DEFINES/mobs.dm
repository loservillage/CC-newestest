#define NUTRITIONAL_GOAL 100
#define DEFAULT_NUTRITIONAL_DECAY -0.025 // (0.025 / 2) * 60 * 30 = 22.5 over 30 minutes. 
#define MIN_REWARD_NUTRITIONAL_DECAY -0.02 // (0.02 / 2) * 60 * 30 = 18 over 30 minutes. 
#define FULL_REWARD_NUTRITIONAL_DECAY -0.01 // (0.02 / 2) * 60 * 30 = 9 over 30 minutes. 

//You can go a little over 100 as a means to keep your nutrition for longer. Going over all 5 goals and reaching over 100 will yield a very strong bonus and reduce nutritional drain.
//Why do we have a minimum? In case we ever decide to add detriments for not maintaining a balanced diet.
#define NUTRITIONAL_MIN_AMT 0
#define NUTRITIONAL_MAX_AMT 125

//Minimum amount of goals to reach to get rewarded the minimum reward.
#define NUTRITIONAL_REWARD_MIN 3 //Default 3

//Maximum amount of goals to reach to get rewarded the maximum reward. Typically relates to all current dietary goals.
#define NUTRITIONAL_REWARD_MAX 5 //Default 5

//Update this if you ever add any new types of diets. This generally will have little use outside of sanity.
#define NUTRITIONAL_DIET_TYPES list("Dairy", "Meats", "Fruits", "Vegetables", "Grains")

//Used for globally adjusting dietary values.
#define FOOD_DIETARY_VALUE_POOR 2
#define FOOD_DIETARY_VALUE_BAD 4
#define FOOD_DIETARY_VALUE_GOOD 6
#define FOOD_DIETARY_VALUE_GREAT 12
#define FOOD_DIETARY_VALUE_AMAZING 18
#define FOOD_DIETARY_VALUE_LEGENDARY 22

//Used specifically for reagents.
#define FOOD_DIETARY_REAGENT_VALUE_POOR 0.5
#define FOOD_DIETARY_REAGENT_VALUE_BAD 0.75
#define FOOD_DIETARY_REAGENT_VALUE_GOOD 1
#define FOOD_DIETARY_REAGENT_VALUE_GREAT 1.25
#define FOOD_DIETARY_REAGENT_VALUE_AMAZING 1.5
#define FOOD_DIETARY_REAGENT_VALUE_LEGENDARY 2
