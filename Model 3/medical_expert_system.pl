/* this is a basic program that provide a menu of symptoms, allow user to choose from it then rank it based on how many symptoms are matching a disease.
 Also, symptoms have weights for better scoring. Result of this model will be ranked diagnoses from highest to lowest and a treatment for only the top one
Note: any disease that score less than .45 will be exculded from the ranked diagnoses 
This model have no issues and it solves all issue faced in model 1 and 2
*/

% Knowloge base - Disese with their symptoms and symptoms' weight
disease(flu, [
    fever-3,
    cough-3,
    sore_throat-2,
    runny_nose-2,
    fatigue-1
]).

disease(covid, [
    fever-3,
    cough-2,
    shortness_of_breath-5,
    loss_of_smell-4,
    fatigue-2
]).

disease(pneumonia, [
    fever-3,
    cough-2,
    shortness_of_breath-5,
    chest_pain-4,
    fatigue-1
]).

disease(common_cold, [
    cough-2,
    sore_throat-3,
    runny_nose-3,
    sneezing-3
]).

disease(allergy, [
    sneezing-4,
    itchy_eyes-4,
    runny_nose-3,
    nasal_congestion-3
]).

disease(uti, [
    burning_urination-5,
    frequent_urination-4,
    lower_abdominal_pain-3,
    cloudy_urine-3
]).

disease(gastroenteritis, [
    diarrhea-4,
    vomiting-4,
    abdominal_cramps-3,
    fever-2
]).

disease(diabetes, [
    increased_thirst-5,
    frequent_urination-4,
    fatigue-2,
    blurred_vision-4
]).


start :-
    writeln('Enter symptoms by number. Enter 0 to finish.'),
    symptom_menu,
    read_selected_symptoms(Symptoms),
    nl,
    write('Your symptoms are: '),
    writeln(Symptoms),
    nl,
    diagnose(Symptoms).

symptom_menu :-
    writeln('1. fever'),
    writeln('2. cough'),
    writeln('3. sore_throat'),
    writeln('4. runny_nose'),
    writeln('5. shortness_of_breath'),
    writeln('6. loss_of_smell'),
    writeln('7. chest_pain'),
    writeln('8. sneezing'),
    writeln('9. itchy_eyes'),
    writeln('10. nasal_congestion'),
    writeln('11. burning_urination'),
    writeln('12. frequent_urination'),
    writeln('13. diarrhea'),
    writeln('14. vomiting'),
    writeln('15. abdominal_cramps'),
    writeln('16. increased_thirst'),
    writeln('17. fatigue'),
    writeln('18. blurred_vision'),
    writeln('19. lower_abdominal_pain'),
    writeln('20. cloudy_urine').


read_selected_symptoms(Symptoms) :-
    read(N),
    (   N == 0
    ->  Symptoms = []
    ;   symptom_number(N, Symptom)
    ->  Symptoms = [Symptom | Rest],
        read_selected_symptoms(Rest)
    ;   writeln('Invalid choice, try again.'),
        read_selected_symptoms(Symptoms)
    ).

symptom_number(1, fever).
symptom_number(2, cough).
symptom_number(3, sore_throat).
symptom_number(4, runny_nose).
symptom_number(5, shortness_of_breath).
symptom_number(6, loss_of_smell).
symptom_number(7, chest_pain).
symptom_number(8, sneezing).
symptom_number(9, itchy_eyes).
symptom_number(10, nasal_congestion).
symptom_number(11, burning_urination).
symptom_number(12, frequent_urination).
symptom_number(13, diarrhea).
symptom_number(14, vomiting).
symptom_number(15, abdominal_cramps).
symptom_number(16, increased_thirst).
symptom_number(17, fatigue).
symptom_number(18, blurred_vision).
symptom_number(19, lower_abdominal_pain).
symptom_number(20, cloudy_urine).

diagnose(Symptoms) :-
    findall(
        Score-Disease-MW-TW-MC-TC,
        (disease_score(Symptoms, Disease, Score, MW, TW, MC, TC),
         Score >= 0.60),   % remove disease that have low score
        Results
    ),
    sort(Results, SortedAsc),
    reverse(SortedAsc, SortedDesc),
    writeln('Ranked diagnoses:'),
    print_ranked(SortedDesc),
    nl,
    show_treatment(SortedDesc).

disease_score(Symptoms, Disease, Score, MatchedWeight, TotalWeight, MatchedCount, TotalCount) :-
    disease(Disease, Required),
    length(Required, TotalCount),
    total_weight(Required, TotalWeight),
    matched_weight(Symptoms, Required, 0, 0, MatchedWeight, MatchedCount),
    TotalWeight > 0,
    Score is MatchedWeight / TotalWeight.

total_weight([], 0).
total_weight([_-W|T], Total) :-
    total_weight(T, Rest),
    Total is Rest + W.

matched_weight(_, [], MW, MC, MW, MC).

matched_weight(Symptoms, [S-W|T], AccW, AccC, TotalW, TotalC) :-
    member(S, Symptoms),
    NewW is AccW + W,
    NewC is AccC + 1,
    matched_weight(Symptoms, T, NewW, NewC, TotalW, TotalC).

matched_weight(Symptoms, [S-_|T], AccW, AccC, TotalW, TotalC) :-
    \+ member(S, Symptoms),
    matched_weight(Symptoms, T, AccW, AccC, TotalW, TotalC).

print_ranked([]).

print_ranked([Score-Disease-_MW-_TW-MC-TC | Rest]) :-
    format('~w -> score=~2f,  matched_symptoms=~w/~w~n',
           [Disease, Score, MC, TC]),
    print_ranked(Rest).

show_treatment([]) :-
    writeln('No matching disease found.').

show_treatment([_Score-Disease-_-_-_-_ | _]) :-
    nl,
    (   treatment(Disease)
    ->  true
    ;   writeln('No treatment information available.')
    ).


treatment(flu):-
    writeln('You may have flu.'),
    writeln('Make sure to rest and avoid physical effort. Then you can do the following:
1. Drink plenty of fluids (water, soup, warm drinks)
2. Take Paracetamol or Ibuprofen to reduce fever
3. Keep yourself warm and rest well').

treatment(covid):-
    writeln('You may have COVID.'),
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