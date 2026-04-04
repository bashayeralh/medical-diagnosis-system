/* this is a basic program that have adaptive questions (yes and no questions) then try to diagnose it and give treatment accordingly -- containing 19 rules
Limitation in this model:
1. even tho it solves user experince issue in model 1, it might diagnose disease based on 1 symptom depend on excluation because the knowloge base is too small 
For example: if user say they have fever but no cough then it will directly say that they have gastroenteritis
*/

% Knowloge base - Disese with their symptoms
disease(flu, [fever, cough, sore_throat, runny_nose, fatigue]). % Flu
disease(covid19, [fever, cough, shortness_of_breath, loss_of_smell]). % COVID-19
disease(pneumonia, [fever, cough, shortness_of_breath, chest_pain]). % Pneumonia
disease(common_cold, [cough, sore_throat, runny_nose, sneezing]). % Common Cold
disease(allergy, [sneezing, itchy_eyes, runny_nose, nasal_congestion]). % Allergic Rhinitis
disease(uti, [frequent_urination, burning_urination, lower_abdominal_pain, cloudy_urine]). % UTI 
disease(gastroenteritis, [fever, diarrhea, vomiting, abdominal_cramps]). % Gastroenteritis
disease(diabetes, [frequent_urination, increased_thirst, fatigue, blurred_vision]). % Diabetes (Type 2)

% start with empty list
start :-
    findall(D, disease(D, _), Diseases),
    writeln('Answer with y. or n.'),
    ask_loop(Diseases, []).  % [] = no symptoms asked yet

% one disease left
ask_loop([D], _) :-
    treatment(D).

% no diseases left
ask_loop([], _) :-
    writeln('No matching disease found.').

% multi diseases but no new symptoms left
ask_loop(Diseases, Asked) :-
    \+ choose_symptom(Diseases, Asked, _),
    writeln('Cannot ask more questions.'),
    format('Possible diseases: ~w~n', [Diseases]).

% normal case --> ask next symptom
ask_loop(Diseases, Asked) :-
    choose_symptom(Diseases, Asked, Symptom),
    ask(Symptom, Answer),
    update_diseases(Diseases, Symptom, Answer, NewDiseases),
    ask_loop(NewDiseases, [Symptom|Asked]).

ask(Symptom, Answer) :-
    format('Do you have ~w? (y/n): ', [Symptom]),
    read(Answer).

% incdule diseases that have the entered symptom
update_diseases(Diseases, Symptom, y, Filtered) :-
    include(has_symptom(Symptom), Diseases, Filtered).

% exclude diseases that have the entered symptom
update_diseases(Diseases, Symptom, n, Filtered) :-
    include(not_has_symptom(Symptom), Diseases, Filtered).

% check if disease has the symptom
has_symptom(Symptom, Disease) :-
    disease(Disease, Symptoms),
    member(Symptom, Symptoms).

% check if disease does not have symptom
not_has_symptom(Symptom, Disease) :-
    disease(Disease, Symptoms),
    \+ member(Symptom, Symptoms).


choose_symptom(Diseases, Asked, Symptom) :-
    % find symptom from remaining diseases that we didn't ask about yet
    member(D, Diseases),
    disease(D, Symptoms),
    member(Symptom, Symptoms),
    \+ member(Symptom, Asked),  % skip asked symptoms
    !.  % cut to stop after first unasked symptom

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