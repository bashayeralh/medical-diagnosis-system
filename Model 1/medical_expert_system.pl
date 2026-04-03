/* this is a basic program that ask user to enter their symptoms and try to diagnose it and give treatment accordingly -- containing 21 rules
Limitation in this model:
1. It compare the full list of symptoms so if one symptom is missing it will not diagnose (no parial comparison)
2. Not user friendly, if user mismisspelled any symptom it won't diagnose  */
start :-
    writeln('Enter your symptoms one by one followed by dot. Then enter stop.'), 
    writeln('Symptoms you may enter: 
        1. fever
        2. cough
        3. sore_throat
        4. runny_nose
        5. shortness_of_breath
        6. loss_of_smell
        7. chest_pain
        8. sneezing
        9. itchy_eyes
        10. nasal_congestion
        11. burning_urination
        12. frequent_urination
        13. diarrhea
        14. vomiting
        15. abdominal_cramps
        16. increased_thirst
        17. fatigue
        18. blurred_vision
        19. lower_abdominal_pain
        20. cloudy_urine'), 
    read_symptoms(Symptoms),
    diagnose(Symptoms).

read_symptoms(Symptoms) :-
    read(Input),
    ( Input == stop ->
        Symptoms = []
    ;
        Symptoms = [Input | Rest],
        read_symptoms(Rest)
    ).

diagnose(Symptoms) :-
    hasDisease(Disease, Symptoms),
    treatment(Disease).

diagnose(_) :-
    writeln('The Symptoms you entered cannot be diagnosed').

hasSymptom(Symptom, SymptomsList) :-
    member(Symptom, SymptomsList).

% Flu
hasDisease(flu, Symptoms) :- 
    hasSymptom(fever, Symptoms),
    hasSymptom(cough, Symptoms),
    hasSymptom(sore_throat, Symptoms),
    hasSymptom(runny_nose, Symptoms).

% COVID-19
hasDisease(covid, Symptoms) :-
    hasSymptom(fever, Symptoms),
    hasSymptom(cough, Symptoms),
    hasSymptom(shortness_of_breath, Symptoms),
    hasSymptom(loss_of_smell, Symptoms).

% Pneumonia
hasDisease(pneumonia, Symptoms) :-
    hasSymptom(fever, Symptoms),
    hasSymptom(cough, Symptoms),
    hasSymptom(shortness_of_breath, Symptoms),
    hasSymptom(chest_pain, Symptoms).

% Common Cold
hasDisease(common_cold, Symptoms) :-
    hasSymptom(sneezing, Symptoms),
    hasSymptom(cough, Symptoms),
    hasSymptom(runny_nose, Symptoms),
    hasSymptom(sore_throat, Symptoms).

 % Allergic Rhinitis
hasDisease(allergy, Symptoms) :-
    hasSymptom(sneezing, Symptoms),
    hasSymptom(itchy_eyes, Symptoms),
    hasSymptom(runny_nose, Symptoms),
    hasSymptom(nasal_congestion, Symptoms).

% Urinary Tract Infection
hasDisease(uti, Symptoms) :-
    hasSymptom(burning_urination, Symptoms),
    hasSymptom(frequent_urination, Symptoms),
    hasSymptom(lower_abdominal_pain, Symptoms),
    hasSymptom(cloudy_urine, Symptoms).

% Gastroenteritis
hasDisease(gastroenteritis, Symptoms) :-
    hasSymptom(diarrhea, Symptoms),
    hasSymptom(vomiting, Symptoms),
    hasSymptom(abdominal_cramps, Symptoms),
    hasSymptom(fever, Symptoms).

% Diabetes (Type 2)
hasDisease(diabetes, Symptoms) :-
    hasSymptom(increased_thirst, Symptoms),
    hasSymptom(frequent_urination, Symptoms),
    hasSymptom(fatigue, Symptoms),
    hasSymptom(blurred_vision, Symptoms).

treatment(flu):-
    writeln('You may have flu.'),
    writeln('Make sure to rest and avoid physical effort. Then you can do the following:
1. Drink plenty of fluids (water, soup, warm drinks)
2. Take Paracetamol or Ibuprofen to reduce fever
3. Keep yourself warm and rest well').

treatment(covid):-
    writeln('You may have COVID-19.'),
    writeln('First of all, you should take a COVID test to confirm the diagnosis. Then you can do the following:
1. Isolate yourself to avoid spreading infection
2. Rest and drink plenty of fluids
3. Take Paracetamol for fever
4. Consult a doctor about antivirals like Paxlovid
5. Seek urgent care if you have difficulty breathing').

treatment(pneumonia):-
    writeln('You may have pneumonia.'),
    writeln('You should see a doctor as soon as possible to confirm the diagnosis. Then:
1. Take prescribed antibiotics such as Amoxicillin
2. Get plenty of rest
3. Drink fluids regularly
4. Use Ibuprofen for pain and fever
5. Go to the hospital if symptoms become severe').

treatment(common_cold):-
    writeln('You may have a common cold.'),
    writeln('This is usually mild, and you can manage it by doing the following:
1. Rest and stay hydrated
2. Take Paracetamol if needed
3. Use decongestants like Pseudoephedrine
4. Drink warm fluids').

treatment(allergy):-
    writeln('You may have an allergy.'),
    writeln('Try to identify and avoid triggers first. Then:
1. Take antihistamines like Loratadine or Cetirizine
2. Avoid dust, pollen, or other allergens
3. Use nasal sprays if necessar').

treatment(uti):-
    writeln('You may have a UTI.'),
    writeln('You should visit a doctor to confirm. Then:
1. Drink plenty of water
2. Take prescribed antibiotics such as Nitrofurantoin
3. Do not delay treatment to avoid complications').

treatment(gastroenteritis):-
    writeln('You may have gastroenteritis.'),
    writeln('The main goal is to prevent dehydration. You should:
1. Drink oral rehydration solutions frequently
2. Rest and eat light foods
3. Take anti-vomiting medicine like Ondansetron if needed
4. Seek help if dehydration symptoms appear').  

treatment(diabetes):-
    writeln('You may have diabetes.'),
    writeln('You should do a blood sugar test to confirm. Then:
1. Follow a healthy diet
2. Exercise regularly
3. Take medications such as Metformin as prescribed
4. Monitor your blood sugar levels regularly').   